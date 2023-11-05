import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';

import '../../../../core/error/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<AuthModel>>> searchUser(String searchQuery);
}
