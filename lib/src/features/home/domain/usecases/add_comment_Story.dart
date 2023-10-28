import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class AddCommentStoryUsecase {
  final HomeRepository baseHomeRepository;
  AddCommentStoryUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(String storyId, String comment) async {
    return await baseHomeRepository.storyComment(storyId, comment);
  }
}