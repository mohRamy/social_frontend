import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/auth_model.dart';
import '../repository/base_auth_repository.dart';

class GetUserInfoAuthUsecase {
  final AuthRepository baseAuthRepository;
  GetUserInfoAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, AuthModel>> call() async {
    return await baseAuthRepository.getInfoUser();
  }
}