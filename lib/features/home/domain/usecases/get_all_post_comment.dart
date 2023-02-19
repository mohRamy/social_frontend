import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/comment.dart';
import '../repository/base_home_repository.dart';

class GetAllPostCommentUsecase {
  final BaseHomeRepository baseHomeRepository;
  GetAllPostCommentUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<Comment>>> execute(String postId) async {
    return await baseHomeRepository.getAllPostComment(postId);
  }
}