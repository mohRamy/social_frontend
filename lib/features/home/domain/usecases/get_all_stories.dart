import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/story.dart';
import '../repository/base_home_repository.dart';

class GetAllStoriesUsecase {
  final HomeRepository baseHomeRepository;
  GetAllStoriesUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<Story>>> call() async {
    return await baseHomeRepository.getAllStories();
  }
}