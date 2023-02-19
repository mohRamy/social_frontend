import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repository/base_auth_repository.dart';

class SignInAuthUsecase {
  final BaseAuthRepository baseAuthRepository;
  SignInAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Auth>> execute(String email, String password) async {
    return await baseAuthRepository.signIn(email, password);
  }
}
