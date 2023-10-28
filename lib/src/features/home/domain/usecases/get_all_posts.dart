import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class GetAllPostsUsecase {
  final HomeRepository baseHomeRepository;
  GetAllPostsUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call() async {
    return await baseHomeRepository.getAllPosts();
  }
}