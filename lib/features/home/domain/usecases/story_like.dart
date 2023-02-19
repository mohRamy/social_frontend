import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class StoryLikeUsecase {
  final BaseHomeRepository baseHomeRepository;
  StoryLikeUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> execute(String storyId) async {
    return await baseHomeRepository.storyLike(storyId);
  }
}