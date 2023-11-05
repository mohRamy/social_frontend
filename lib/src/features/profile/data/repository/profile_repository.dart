import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../domain/repository/base_profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

typedef Future<Unit> GetMessage();

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource baseProfileRemoteDataSource;
  final NetworkInfo networkInfo;
  ProfileRepositoryImpl(this.baseProfileRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> changePassword(String currentPassword, String newPassword) async {
    return await _getMessage(() {
      return baseProfileRemoteDataSource.changePassword(currentPassword, newPassword);
    });
  }

  @override
  Future<Either<Failure, Unit>> followUser(String userId) async {
    return await _getMessage(() {
      return baseProfileRemoteDataSource.followUser(userId);
    });
  }

  @override
  Future<Either<Failure, List<PostModel>>> getUserPosts() async {
        if (await networkInfo.isConnected) {
      try {
        final result = await baseProfileRemoteDataSource.getUserPosts();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getUserPostsById(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseProfileRemoteDataSource.getUserPostsById(userId);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> modifyMyData(Auth myData) async {
    return await _getMessage(() {
      return baseProfileRemoteDataSource.updateInfo(myData);
    });
  }

  @override
  Future<Either<Failure, Unit>> privateAccount() async {
    return await _getMessage(() {
      return baseProfileRemoteDataSource.privateAccount();
    });
  }

  Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return right(unit);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }
}
