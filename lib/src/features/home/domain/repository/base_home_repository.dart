import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/comment.dart';
import '../entities/story.dart';


abstract class HomeRepository {
  // post
  Future<Either<Failure, Unit>> getAllPosts();
  Future<Either<Failure, Unit>> modifyPost(String postId, String description);
  Future<Either<Failure, Unit>> deletePost(String postId);
  Future<Either<Failure, Unit>> addLikePost(String postId);
  Future<Either<Failure, Unit>> addCommentPost(String postId, String comment);
  Future<Either<Failure, List<Comment>>> getAllPostComment(String postId);
  Future<Either<Failure, Unit>> addLikeCommentPost(
      String postId, String commentId);
  // story
  Future<Either<Failure, List<Story>>> getAllStories();
  Future<Either<Failure, Unit>> addStory(List<String> storiesUrl, List<String> storiesType);
  Future<Either<Failure, List<Comment>>> getAllStoryComment(String storyId);
  Future<Either<Failure, Unit>> storyLike(String storyId);
  Future<Either<Failure, Unit>> storyComment(String storyId, String comment);
  Future<Either<Failure, Unit>> storyCommentLike(
      String storyId, String commentId);
}
