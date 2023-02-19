import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:social_app/core/error/failures.dart';
import 'package:social_app/features/home/domain/entities/comment.dart';
import 'package:social_app/features/home/domain/entities/post.dart';
import 'package:social_app/features/home/domain/entities/story.dart';

import '../../../../core/enums/story_enum.dart';

abstract class BaseHomeRepository {
  // post
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> updatePost(String postId, String description);
  Future<Either<Failure, Unit>> deletePost(String postId);
  Future<Either<Failure, Unit>> postLike(String postId);
  Future<Either<Failure, Unit>> postComment(String postId, String comment);
  Future<Either<Failure, List<Comment>>> getAllPostComment(String postId);
  Future<Either<Failure, Unit>> postCommentLike(
      String postId, String commentId);
  // story
  Future<Either<Failure, List<Story>>> getAllStories();
  Future<Either<Failure, Unit>> addStory(
    List<Map<StoryEnum, File>> story,
  );
  Future<Either<Failure, List<Comment>>> getAllStoryComment(String storyId);
  Future<Either<Failure, Unit>> storyLike(String storyId);
  Future<Either<Failure, Unit>> storyComment(String storyId, String comment);
  Future<Either<Failure, Unit>> storyCommentLike(
      String storyId, String commentId);
}
