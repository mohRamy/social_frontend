import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class RequistRepository{
  Future<Either<Failure, Unit>> changeUserCase(String userId, bool isDelete);
}