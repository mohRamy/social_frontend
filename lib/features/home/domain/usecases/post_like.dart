import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class PostLikeUsecase {
  final BaseHomeRepository baseHomeRepository;
  PostLikeUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> execute(String postId) async {
    return await baseHomeRepository.postLike(postId);
  }
}