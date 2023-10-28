import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';

abstract class AuthRepository{
  Future<Either<Failure, Unit>> register(Auth auth);
  Future<Either<Failure, Auth>> login(String email, String password);
  Future<Either<Failure, bool>> isTokenValid();
  Future<Either<Failure, Auth>> fetchInfoUser();
  Future<Either<Failure, Auth>> fetchInfoUserById(String userId);
}