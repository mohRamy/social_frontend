import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repository/base_auth_repository.dart';

class GetUserInfoByIdAuthUsecase {
  final AuthRepository baseAuthRepository;
  GetUserInfoByIdAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Auth>> call(String userId) async {
    return await baseAuthRepository.fetchInfoUserById(userId);
  }
}