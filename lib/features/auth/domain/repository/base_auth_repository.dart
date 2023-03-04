import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';

abstract class BaseAuthRepository{
  Future<Either<Failure, Unit>> signUp(Auth auth);
  Future<Either<Failure, Auth>> signIn(String email, String password);
  Future<Either<Failure, bool>> isTokenValid();
  Future<Either<Failure, Auth>> getMyData();
  Future<Either<Failure, Auth>> getUserData(String userId);
}