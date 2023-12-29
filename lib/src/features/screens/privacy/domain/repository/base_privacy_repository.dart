import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class PrivacyRepository {
  Future<Either<Failure, Unit>> privateAccount();
}