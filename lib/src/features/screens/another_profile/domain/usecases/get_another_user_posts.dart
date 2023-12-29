import 'package:dartz/dartz.dart';
import '../repository/base_another_profile_repository.dart';
import '../../../../taps/home/data/models/post_model.dart';

import '../../../../../core/error/failures.dart';

class GetAnotherUserPostsUseCase {
  final AnotherProfileRepository baseAnotherUserRepository;
  GetAnotherUserPostsUseCase(this.baseAnotherUserRepository);

  Future<Either<Failure, List<PostModel>>> call(String userId) async {
    return await baseAnotherUserRepository.getAnotherUserPosts(userId);
  }
}