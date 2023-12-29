import 'package:dartz/dartz.dart';
import '../datasources/udpate_post_remote_datasource.dart';
import '../../domain/repository/base_udpate_post_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class UpdatePostRepositoryImpl extends UpdatePostRepository {
  final UpdatePostRemoteDataSource baseUpdatePostRemoteDataSource;
  final NetworkInfo networkInfo;
  UpdatePostRepositoryImpl(
    this.baseUpdatePostRemoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Unit>> updatePost(String postId, String description) async {
    return await _getMessage(() {
      return baseUpdatePostRemoteDataSource.updatePost(postId, description);
    });
  }

    Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return const Right(unit);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }
}
