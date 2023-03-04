import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_profile_repository.dart';

class PrivateAccountUseCase {
  final ProfileRepository baseProfileRepository;
  PrivateAccountUseCase(this.baseProfileRepository);

  Future<Either<Failure, Unit>> call() async {
    return await baseProfileRepository.privateAccount();
  }
}
