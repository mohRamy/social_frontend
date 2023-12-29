import 'package:dartz/dartz.dart';
import '../repository/base_comment_repository.dart';

import '../../../../../core/error/failures.dart';

class ChangeCommentLikeUsecase {
  final CommentRepository baseCommentRepository;
  ChangeCommentLikeUsecase(this.baseCommentRepository);

  Future<Either<Failure, Unit>> call(
    String itemId,
    String itemType,
    String commentId,
  ) async {
    return await baseCommentRepository.changeCommentLike(
      itemId,
      itemType,
      commentId,
    );
  }
}
