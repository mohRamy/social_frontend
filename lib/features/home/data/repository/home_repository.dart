import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:social_app/core/enums/story_enum.dart';
import 'package:social_app/core/error/failures.dart';
import 'package:social_app/core/network/network_info.dart';
import 'package:social_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:social_app/features/home/domain/entities/comment.dart';
import 'package:social_app/features/home/domain/entities/post.dart';
import 'package:social_app/features/home/domain/entities/story.dart';
import 'package:social_app/features/home/domain/repository/base_home_repository.dart';

import '../../../../core/error/exceptions.dart';

class HomeRepository extends BaseHomeRepository {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;
  final NetworkInfo networkInfo;
  HomeRepository({
    required this.baseHomeRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> addStory(List<Map<StoryEnum, File>> story) async {
    await baseHomeRemoteDataSource.addStory(story);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    await baseHomeRemoteDataSource.deletePost(postId);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllPostComment(String postId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllPostComment(postId);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllPosts();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getAllStories() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllStories();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllStoryComment(String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllStoryComment(storyId);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> postComment(String postId, String comment) async {
    await baseHomeRemoteDataSource.postComment(postId, comment);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, Unit>> postCommentLike(String postId, String commentId) async {
    await baseHomeRemoteDataSource.postCommentLike(postId, commentId);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, Unit>> postLike(String postId) async {
    await baseHomeRemoteDataSource.postLike(postId);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, Unit>> storyComment(String storyId, String comment) async {
    await baseHomeRemoteDataSource.storyComment(storyId, comment);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, Unit>> storyCommentLike(String storyId, String commentId) async {
    await baseHomeRemoteDataSource.storyCommentLike(storyId, commentId);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, Unit>> storyLike(String storyId) async {
    await baseHomeRemoteDataSource.storyLike(storyId);
    return await _getMessage();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(String postId, String description) async {
    await baseHomeRemoteDataSource.updatePost(postId, description);
    return await _getMessage();
  }

  Future<Either<Failure, Unit>> _getMessage() async {
    if (await networkInfo.isConnected) {
      try {
        return right(unit);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

}
