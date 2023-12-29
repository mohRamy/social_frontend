import 'package:dartz/dartz.dart';
import '../repository/base_udpate_post_repository.dart';

import '../../../../../core/error/failures.dart';

class UpdatePostUseCase {
  final UpdatePostRepository baseUpdatePostRepository;
  UpdatePostUseCase(this.baseUpdatePostRepository);

  Future<Either<Failure, Unit>> call(
    String postId,
    String description,
  ) async {
    return await baseUpdatePostRepository.updatePost(
      postId,
      description,
    );
  }
}
