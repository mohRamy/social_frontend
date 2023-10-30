import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Auth>>> searchUser(String searchQuery);
}
