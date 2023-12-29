import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/auth_model.dart';
import '../repository/base_auth_repository.dart';

class GetUserInfoByIdAuthUsecase {
  final AuthRepository baseAuthRepository;
  GetUserInfoByIdAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, AuthModel>> call(String userId) async {
    return await baseAuthRepository.getInfoUserById(userId);
  }
}