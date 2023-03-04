import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repository/base_auth_repository.dart';

class GetUserDataAuthUsecase {
  final BaseAuthRepository baseAuthRepository;
  GetUserDataAuthUsecase(this.baseAuthRepository);

  Future<Either<Failure, Auth>> call(String userId) async {
    return await baseAuthRepository.getUserData(userId);
  }
}