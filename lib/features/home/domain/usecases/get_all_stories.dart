import 'package:dartz/dartz.dart';
import 'package:social_app/features/home/domain/entities/story.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class GetAllStoriesUsecase {
  final BaseHomeRepository baseHomeRepository;
  GetAllStoriesUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<Story>>> execute() async {
    return await baseHomeRepository.getAllStories();
  }
}