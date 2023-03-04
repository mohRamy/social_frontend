import 'package:dartz/dartz.dart';
import '../entities/post.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class GetAllPostsUsecase {
  final HomeRepository baseHomeRepository;
  GetAllPostsUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await baseHomeRepository.getAllPosts();
  }
}