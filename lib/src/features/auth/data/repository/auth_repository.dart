import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

typedef GetMessage = Future<Unit> Function();

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource baseAuthRemoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl(
    this.baseAuthRemoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Unit>> register(Auth auth) async {
    return await _getMessage((){
      return baseAuthRemoteDataSource.register(auth);
    });
  }

  @override
  Future<Either<Failure, Auth>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.login(email, password);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, bool>> isTokenValid() async {
    try {
        final result = await baseAuthRemoteDataSource.isTokenValid();
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
  }

  @override
  Future<Either<Failure, Auth>> fetchInfoUser() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.fetchUserInfo();
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Auth>> fetchInfoUserById(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.fetchUserInfoById(userId);
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
