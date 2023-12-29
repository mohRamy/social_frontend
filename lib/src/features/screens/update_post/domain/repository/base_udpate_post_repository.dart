import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class UpdatePostRepository {
  Future<Either<Failure, Unit>> updatePost(String postId, String description);
}
