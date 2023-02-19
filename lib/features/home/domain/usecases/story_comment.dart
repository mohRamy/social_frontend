import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class StoryCommentUsecase {
  final BaseHomeRepository baseHomeRepository;
  StoryCommentUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> execute(String storyId, String comment) async {
    return await baseHomeRepository.storyComment(storyId, comment);
  }
}