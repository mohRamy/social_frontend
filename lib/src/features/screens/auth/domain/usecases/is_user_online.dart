import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../repository/base_auth_repository.dart';

class IsUserOnlineUsecase {
  final AuthRepository baseAuthRepository;
  IsUserOnlineUsecase(this.baseAuthRepository);

  Future<Either<Failure, Unit>> call(bool isOnline) async {
    return await baseAuthRepository.isUserOnline(isOnline);
  }
}