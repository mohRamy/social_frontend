import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../repository/base_add_post_repository.dart';

class AddPostUseCase {
  final AddPostRepository basePostRepository;
  AddPostUseCase(this.basePostRepository);

  Future<Either<Failure, Unit>> call(String description, List<String> postsUrl, List<String> postsType) async {
    return await basePostRepository.addPost(description, postsUrl, postsType);
  }
}
