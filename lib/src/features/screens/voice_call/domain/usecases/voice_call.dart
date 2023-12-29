import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/view_story/domain/repository/base_view_story_repository.dart';

import '../../../../../core/error/failures.dart';

class VoiceCallUsecase {
  final ViewStoryRepository baseViewStoryRepository;
  VoiceCallUsecase(this.baseViewStoryRepository);

  Future<Either<Failure, Unit>> call(String storyId) async {
    return await baseViewStoryRepository.changeStoryLike(storyId);
  }
}