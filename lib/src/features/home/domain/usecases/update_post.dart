import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class ModifyPostUsecase {
  final HomeRepository baseHomeRepository;
  ModifyPostUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(String postId, String description) async {
    return await baseHomeRepository.updatePost(postId, description);
  }
}