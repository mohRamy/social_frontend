import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_profile_repository.dart';

import '../../../home/domain/entities/post.dart';

class GetUserPostsUseCase {
  final ProfileRepository baseProfileRepository;
  GetUserPostsUseCase(this.baseProfileRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await baseProfileRepository.getUserPosts();
  }
}