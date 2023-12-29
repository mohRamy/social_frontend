import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/auth/data/models/auth_model.dart';

import '../../../../../core/error/failures.dart';

abstract class UpdateInfoRepository {
  Future<Either<Failure, Unit>> updateInfo(AuthModel userInfo);
}
