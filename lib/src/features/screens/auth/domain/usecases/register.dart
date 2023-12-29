import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/auth_model.dart';
import '../repository/base_auth_repository.dart';

class RegisterAuthUsecase {
  final AuthRepository baseAuthRepository;
  RegisterAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Unit>> call(AuthModel auth) async {
    return await baseAuthRepository.register(auth);
  }
}