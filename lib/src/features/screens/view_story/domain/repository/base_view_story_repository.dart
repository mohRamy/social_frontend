import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class ViewStoryRepository {
  Future<Either<Failure, Unit>> changeStoryLike(String storyId);
  Future<Either<Failure, Unit>> addStoryShare(String storyId);
}
