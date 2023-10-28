import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class AddCommentPostUsecase {
  final HomeRepository baseHomeRepository;
  AddCommentPostUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(String postId, String comment) async {
    return await baseHomeRepository.addCommentPost(postId, comment);
  }
}