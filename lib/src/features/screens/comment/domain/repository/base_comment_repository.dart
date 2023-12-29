import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/comment.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<Comment>>> getComments(
    String itemId,
    String itemType,
  );
  Future<Either<Failure, Unit>> addComment(
    String itemId,
    String itemType,
    String comment,
  );
  Future<Either<Failure, Unit>> changeCommentLike(
    String itemId,
    String itemType,
    String commentId,
  );
}
