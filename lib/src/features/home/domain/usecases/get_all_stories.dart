import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/story_model.dart';
import '../repository/base_home_repository.dart';

class GetAllStoriesUsecase {
  final HomeRepository baseHomeRepository;
  GetAllStoriesUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<StoryModel>>> call() async {
    return await baseHomeRepository.getAllStories();
  }
}