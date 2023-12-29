import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class WatchRepository{
  Future<Either<Failure, Unit>> getPostWatch();
}