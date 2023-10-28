import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_post_repository.dart';

class AddPostUseCase {
  final PostRepository basePostRepository;
  AddPostUseCase(this.basePostRepository);

  Future<Either<Failure, Unit>> call(String description, List<String> postsUrl, List<String> postsType) async {
    return await basePostRepository.addPost(description, postsUrl, postsType);
  }

}
