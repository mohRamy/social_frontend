import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class StoryCommentLikeUsecase {
  final HomeRepository baseHomeRepository;
  StoryCommentLikeUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(String storyId, String commentId) async {
    return await baseHomeRepository.storyCommentLike(storyId, commentId);
  }
}