import 'package:dartz/dartz.dart';
import '../repository/base_friends_repository.dart';

import '../../../../../core/error/failures.dart';

class RemoveFriendUseCase {
  final FriendsRepository baseFriendsRepository;
  RemoveFriendUseCase(this.baseFriendsRepository);

  Future<Either<Failure, Unit>> call(String userId) async {
    return await baseFriendsRepository.removeFriend(userId);
  }
}
