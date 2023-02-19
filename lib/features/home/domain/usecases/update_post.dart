import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class UpdatePostUsecase {
  final BaseHomeRepository baseHomeRepository;
  UpdatePostUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> execute(String postId, String description) async {
    return await baseHomeRepository.updatePost(postId, description);
  }
}