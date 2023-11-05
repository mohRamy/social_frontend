import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_auth_repository.dart';

class LoginAuthUsecase {
  final AuthRepository baseAuthRepository;
  LoginAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, AuthModel>> call(String email, String password) async {
    return await baseAuthRepository.login(email, password);
  }
}
