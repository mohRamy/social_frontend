import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_profile_repository.dart';

class FollowUserUseCase {
  final BaseProfileRepository baseProfileRepository;
  FollowUserUseCase(this.baseProfileRepository);

  Future<Either<Failure, Unit>> call(String userId) async {
    return await baseProfileRepository.followUser(userId);
  }
}
