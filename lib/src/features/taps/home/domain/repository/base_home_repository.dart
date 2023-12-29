import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/post_model.dart';
import '../../data/models/story_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PostModel>>> getAllPosts();
  Future<Either<Failure, Unit>> getAllPostsSocket();
  Future<Either<Failure, List<StoryModel>>> getAllStories();
  Future<Either<Failure, Unit>> changePostLike(String postId);
  Future<Either<Failure, Unit>> addPostShare(String postId);
  Future<Either<Failure, Unit>> deletePost(String postId);
}
