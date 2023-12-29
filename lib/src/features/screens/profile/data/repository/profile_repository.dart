import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../taps/home/data/models/post_model.dart';
import '../../domain/repository/base_profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

typedef GetMessage = Future<Unit> Function();

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource baseProfileRemoteDataSource;
  final NetworkInfo networkInfo;
  ProfileRepositoryImpl(this.baseProfileRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<PostModel>>> getUserPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseProfileRemoteDataSource.getUserPosts();
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAvatar(String photo, bool isPhoto) async {
    return await _getMessage(() {
      return baseProfileRemoteDataSource.updateAvatar(photo, isPhoto);
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
