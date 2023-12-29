import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../repository/base_auth_repository.dart';

class AddUserFcmTokenUsecase {
  final AuthRepository baseAuthRepository;
  AddUserFcmTokenUsecase(this.baseAuthRepository);

  Future<Either<Failure, Unit>> call(String fcmToken) async {
    return await baseAuthRepository.addUserFcmToken(fcmToken);
  }
}