import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_profile_repository.dart';

class ChangepasswordUseCase {
  final BaseProfileRepository baseProfileRepository;
  ChangepasswordUseCase(this.baseProfileRepository);

  Future<Either<Failure, Unit>> call(String currentPassword, String newPassword) async {
    return await baseProfileRepository.changePassword(currentPassword, newPassword);
  }
}
