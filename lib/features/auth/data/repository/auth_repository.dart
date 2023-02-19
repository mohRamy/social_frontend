import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

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
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(Auth auth) async {
    await baseAuthRemoteDataSource.signUp(auth);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, bool>> isTokenValid() async {
    try {
        final result = await baseAuthRemoteDataSource.isTokenValid();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
  }

  @override
  Future<Either<Failure, Auth>> getMyData() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.getMyData();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Auth>> getUserData(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseAuthRemoteDataSource.getUserData(userId);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  Future<Either<Failure, Unit>> _getMessage() async {
    if (await networkInfo.isConnected) {
      try {
        return right(unit);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }
  
  
}
