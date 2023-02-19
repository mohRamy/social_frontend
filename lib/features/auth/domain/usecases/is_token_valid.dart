import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_auth_repository.dart';

class IsTokenValidAuthUsecase {
  final BaseAuthRepository baseAuthRepository;
  IsTokenValidAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, bool>> execute() async {
    return await baseAuthRepository.isTokenValid();
  }
}