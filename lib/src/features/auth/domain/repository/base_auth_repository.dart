import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/auth_model.dart';
import '../entities/auth.dart';

abstract class AuthRepository{
  Future<Either<Failure, Unit>> register(Auth auth);
  Future<Either<Failure, AuthModel>> login(String email, String password);
  Future<Either<Failure, bool>> isTokenValid();
  Future<Either<Failure, AuthModel>> getInfoUser();
  Future<Either<Failure, AuthModel>> getInfoUserById(String userId);
}