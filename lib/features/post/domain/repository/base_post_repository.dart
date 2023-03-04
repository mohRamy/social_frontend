import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class BasePostRepository {
  Future<Either<Failure, Unit>> addPost(
      String description, List<String> postsUrl, List<String> postsType);
}
