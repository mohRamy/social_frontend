import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repository/base_auth_repository.dart';

class SignUpAuthUsecase {
  final BaseAuthRepository baseAuthRepository;
  SignUpAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Unit>> execute(Auth auth) async {
    return await baseAuthRepository.signUp(auth);
  }
}