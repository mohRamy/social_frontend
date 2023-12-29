import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../taps/home/data/models/post_model.dart';
import '../repository/base_profile_repository.dart';
class GetUserPostsUseCase {
  final ProfileRepository baseProfileRepository;
  GetUserPostsUseCase(this.baseProfileRepository);

  Future<Either<Failure, List<PostModel>>> call() async {
    return await baseProfileRepository.getUserPosts();
  }
}