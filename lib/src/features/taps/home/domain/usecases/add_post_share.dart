import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class AddPostShareUsecase {
  final HomeRepository baseHomeRepository;
  AddPostShareUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(String postId) async {
    return await baseHomeRepository.addPostShare(postId);
  }
}