import 'package:dartz/dartz.dart';
import '../datasources/another_profile_remote_datasource.dart';
import '../../domain/repository/base_another_profile_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../taps/home/data/models/post_model.dart';

typedef GetMessage = Future<Unit> Function();

class AnotherProfileRepositoryImpl extends AnotherProfileRepository {
  final AnotherProfileRemoteDataSource baseAnotherUserRemoteDataSource;
  final NetworkInfo networkInfo;
  AnotherProfileRepositoryImpl(this.baseAnotherUserRemoteDataSource, this.networkInfo);

    @override
  Future<Either<Failure, Unit>> changeUserCase(String userId, bool isDelete) async {
        return await _getMessage(() {
      return baseAnotherUserRemoteDataSource.changeUserCase(userId, isDelete);
    });
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAnotherUserPosts(String userId) async {
    if (await networkInfo.isConnected) {
      try { 
        final result = await baseAnotherUserRemoteDataSource.getAnotherUserPosts(userId);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
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
