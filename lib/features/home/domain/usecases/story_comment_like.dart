import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class StoryCommentLikeUsecase {
  final BaseHomeRepository baseHomeRepository;
  StoryCommentLikeUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> execute(String storyId, String commentId) async {
    return await baseHomeRepository.storyCommentLike(storyId, commentId);
  }
}