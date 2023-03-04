import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/comment.dart';
import '../repository/base_home_repository.dart';

class GetAllStoryCommentUsecase {
  final BaseHomeRepository baseHomeRepository;
  GetAllStoryCommentUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<Comment>>> call(String storyId) async {
    return await baseHomeRepository.getAllStoryComment(storyId);
  }
}