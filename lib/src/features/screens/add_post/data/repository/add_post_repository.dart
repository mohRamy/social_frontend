import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repository/base_add_post_repository.dart';
import '../datasources/add_post_remote_datasource.dart';

typedef GetMessage = Future<Unit> Function();

class AddPostRepositoryImpl extends AddPostRepository {
  final AddPostRemoteDataSource basePostRemoteDataSource;
  final NetworkInfo networkInfo;
  AddPostRepositoryImpl(this.basePostRemoteDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> addPost(
      String description, List<String> postsUrl, List<String> postsType) async {
    return await _getMessage(() {
      return basePostRemoteDataSource.addPost(description, postsUrl, postsType);
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
