import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/auth_model.dart';

abstract class AuthRepository{
  Future<Either<Failure, Unit>> register(AuthModel auth);
  Future<Either<Failure, AuthModel>> login(String email, String password);
  Future<Either<Failure, bool>> isTokenValid();
  Future<Either<Failure, AuthModel>> getInfoUser();
  Future<Either<Failure, AuthModel>> getInfoUserById(String userId);
  Future<Either<Failure, Unit>> isUserOnline(bool isOnline);
  Future<Either<Failure, Unit>> addUserFcmToken(String fcmToken);
}