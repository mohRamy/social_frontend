import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class AddLikeCommentPostUsecase {
  final HomeRepository baseHomeRepository;
  AddLikeCommentPostUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(String postId, String commentId) async {
    return await baseHomeRepository.addLikeCommentPost(postId, commentId);
  }
}