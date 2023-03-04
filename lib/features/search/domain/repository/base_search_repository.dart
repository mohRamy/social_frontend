import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth.dart';

abstract class BaseSearchRepository {
  Future<Either<Failure, List<Auth>>> searchUser(String searchQuery);
}
