import 'package:dartz/dartz.dart';
import '../repository/base_comment_repository.dart';

import '../../../../../core/error/failures.dart';

class AddCommentUseCase {
  final CommentRepository baseCommentRepository;
  AddCommentUseCase(this.baseCommentRepository);

  Future<Either<Failure, Unit>> call(
    String itemId,
    String itemType,
    String comment,
  ) async {
    return await baseCommentRepository.addComment(itemId, itemType, comment);
  }
}
