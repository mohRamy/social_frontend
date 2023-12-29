import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class AddStoryRepository {
  Future<Either<Failure, Unit>> addStory(
    List<String> storiesUrl,
    List<String> storiesType,
  );
}
