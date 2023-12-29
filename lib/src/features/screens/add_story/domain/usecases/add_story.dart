import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/add_story/domain/repository/base_add_story_repository.dart';

import '../../../../../core/error/failures.dart';

class AddStoryUsecase {
  final AddStoryRepository baseAddStoryRepository;
  AddStoryUsecase(this.baseAddStoryRepository);

  Future<Either<Failure, Unit>> call(List<String> storiesUrl, List<String> storiesType) async {
    return await baseAddStoryRepository.addStory(storiesUrl, storiesType);
  }
}