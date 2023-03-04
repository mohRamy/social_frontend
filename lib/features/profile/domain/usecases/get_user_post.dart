import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_profile_repository.dart';

import '../../../home/domain/entities/post.dart';

class GetUserPostUseCase {
  final BaseProfileRepository baseProfileRepository;
  GetUserPostUseCase(this.baseProfileRepository);

  Future<Either<Failure, List<Post>>> call(String userId) async {
    return await baseProfileRepository.getUserPost(userId);
  }
}