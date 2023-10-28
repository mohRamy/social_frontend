import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repository/base_auth_repository.dart';

class GetUserInfoAuthUsecase {
  final AuthRepository baseAuthRepository;
  GetUserInfoAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Auth>> call() async {
    return await baseAuthRepository.fetchInfoUser();
  }
}