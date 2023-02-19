import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/enums/story_enum.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class AddStoryUsecase {
  final BaseHomeRepository baseHomeRepository;
  AddStoryUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> execute(List<Map<StoryEnum, File>> story,) async {
    return await baseHomeRepository.addStory(story);
  }
}