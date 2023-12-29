import 'package:dartz/dartz.dart';
import '../repository/base_comment_repository.dart';

import '../../../../../core/error/failures.dart';
import '../entities/comment.dart';

class GetCommentsUseCase {
  final CommentRepository baseCommentRepository;
  GetCommentsUseCase(this.baseCommentRepository);

  Future<Either<Failure, List<Comment>>> call(
    String itemId,
    String itemType,
  ) async {
    return await baseCommentRepository.getComments(
      itemId,
      itemType,
    );
  }
}
