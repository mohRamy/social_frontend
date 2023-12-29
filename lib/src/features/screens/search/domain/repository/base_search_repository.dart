import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../auth/data/models/auth_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<AuthModel>>> searchUser(String searchQuery);
}
