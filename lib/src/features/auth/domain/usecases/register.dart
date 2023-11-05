import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repository/base_auth_repository.dart';

class RegisterAuthUsecase {
  final AuthRepository baseAuthRepository;
  RegisterAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Unit>> call(Auth auth) async {
    return await baseAuthRepository.register(auth);
  }
}