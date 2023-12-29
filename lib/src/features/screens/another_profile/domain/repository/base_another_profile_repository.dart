import 'package:dartz/dartz.dart';
import '../../../../taps/home/data/models/post_model.dart';

import '../../../../../core/error/failures.dart';

abstract class AnotherProfileRepository{
  Future<Either<Failure, Unit>> changeUserCase(String userId, bool isDelete);
  Future<Either<Failure, List<PostModel>>> getAnotherUserPosts(String userId);
}