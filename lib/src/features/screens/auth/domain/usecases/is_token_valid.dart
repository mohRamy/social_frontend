import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../repository/base_auth_repository.dart';

class IsTokenValidAuthUsecase {
  final AuthRepository baseAuthRepository;
  IsTokenValidAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, bool>> call() async {
    return await baseAuthRepository.isTokenValid();
  }
}