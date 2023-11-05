import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_profile_repository.dart';
class GetUserPostsUseCase {
  final ProfileRepository baseProfileRepository;
  GetUserPostsUseCase(this.baseProfileRepository);

  Future<Either<Failure, List<PostModel>>> call() async {
    return await baseProfileRepository.getUserPosts();
  }
}