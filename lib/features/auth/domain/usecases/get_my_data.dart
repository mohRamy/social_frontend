import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repository/base_auth_repository.dart';

class GetMyDataAuthUsecase {
  final BaseAuthRepository baseAuthRepository;
  GetMyDataAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Auth>> execute() async {
    return await baseAuthRepository.getMyData();
  }
}