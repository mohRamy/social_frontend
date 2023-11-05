import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/post_model.dart';
import '../../data/models/story_model.dart';
import '../entities/comment.dart';


abstract class HomeRepository {
  // post
  Future<Either<Failure, List<PostModel>>> getAllPosts();
  Future<Either<Failure, Unit>> getAllPostsSocket();
  Future<Either<Failure, Unit>> updatePost(String postId, String description);
  Future<Either<Failure, Unit>> deletePost(String postId);
  Future<Either<Failure, Unit>> addLikePost(String postId);
  Future<Either<Failure, Unit>> addCommentPost(String postId, String comment);
  Future<Either<Failure, List<Comment>>> getAllPostComment(String postId);
  Future<Either<Failure, Unit>> addLikeCommentPost(
      String postId, String commentId);
  // story
  Future<Either<Failure, List<StoryModel>>> getAllStories();
  Future<Either<Failure, Unit>> addStory(List<String> storiesUrl, List<String> storiesType);
  Future<Either<Failure, List<Comment>>> getAllStoryComment(String storyId);
  Future<Either<Failure, Unit>> storyLike(String storyId);
  Future<Either<Failure, Unit>> storyComment(String storyId, String comment);
  Future<Either<Failure, Unit>> storyCommentLike(
      String storyId, String commentId);
}
