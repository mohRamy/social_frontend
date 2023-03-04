import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, Unit>> addPost(
      String description, List<String> postsUrl, List<String> postsType);
}
