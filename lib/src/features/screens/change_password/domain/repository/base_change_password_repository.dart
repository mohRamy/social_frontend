import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, Unit>> changePassword(String currentPassword, String newPassword);
}
