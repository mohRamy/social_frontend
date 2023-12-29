import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';

abstract class FriendsRepository {
  Future<Either<Failure, Unit>> removeFriend(String userId);
}
