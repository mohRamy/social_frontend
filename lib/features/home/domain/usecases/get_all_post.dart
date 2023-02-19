import 'package:dartz/dartz.dart';
import 'package:social_app/features/home/domain/entities/post.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class GetAllPostsUsecase {
  final BaseHomeRepository baseHomeRepository;
  GetAllPostsUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<Post>>> execute() async {
    return await baseHomeRepository.getAllPosts();
  }
}