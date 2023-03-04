import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

typedef Future<Unit> GetMessage();

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepository(
    this.baseAuthRemoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Auth>> signIn(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.signIn(email, password);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(Auth auth) async {
    return await _getMessage((){
      return baseAuthRemoteDataSource.signUp(auth);
    });
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
  Future<Either<Failure, Auth>> getMyData() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.getMyData();
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Auth>> getUserData(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.getUserData(userId);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return Left(OfflineFailure(message: "Offline failure"));
    }
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
      return left(OfflineFailure(message: "Offline failure"));
    }
  }
}
