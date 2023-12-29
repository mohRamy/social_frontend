import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../taps/home/data/models/post_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<PostModel>>> getUserPosts();
  Future<Either<Failure, Unit>> updateAvatar(String photo, bool isPhoto);
}
