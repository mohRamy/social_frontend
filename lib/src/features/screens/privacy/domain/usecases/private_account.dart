import 'package:dartz/dartz.dart';
import '../repository/base_privacy_repository.dart';

import '../../../../../core/error/failures.dart';

class PrivateAccountUseCase {
  final PrivacyRepository basePrivacyRepository;
  PrivateAccountUseCase(this.basePrivacyRepository);

  Future<Either<Failure, Unit>> call() async {
    return await basePrivacyRepository.privateAccount();
  }
}
