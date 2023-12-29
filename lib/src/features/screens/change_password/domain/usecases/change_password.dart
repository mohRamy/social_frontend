import 'package:dartz/dartz.dart';
import '../repository/base_change_password_repository.dart';
import '../../../../../core/error/failures.dart';

class ChangepasswordUseCase {
  final ChangePasswordRepository baseChangePasswordRepository;
  ChangepasswordUseCase(this.baseChangePasswordRepository);

  Future<Either<Failure, Unit>> call(String currentPassword, String newPassword) async {
    return await baseChangePasswordRepository.changePassword(currentPassword, newPassword);
  }
}
