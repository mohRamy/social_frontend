import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class PostCommentUsecase {
  final BaseHomeRepository baseHomeRepository;
  PostCommentUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(String postId, String comment) async {
    return await baseHomeRepository.postComment(postId, comment);
  }
}