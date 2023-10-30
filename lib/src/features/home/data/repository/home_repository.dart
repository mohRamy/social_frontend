import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/story.dart';
import '../../domain/repository/base_home_repository.dart';
import '../datasources/home_remote_datasource.dart';

typedef GetMessage = Future<Unit> Function();
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource baseHomeRemoteDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl(this.baseHomeRemoteDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> addStory(
      List<String> storiesUrl, List<String> storiesType) async { 
    return await _getMessage((){
      return baseHomeRemoteDataSource.addStory(storiesUrl, storiesType);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllPostComment(
      String postId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllPostComment(postId);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllPosts();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
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
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllStoryComment(
      String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await baseHomeRemoteDataSource.getAllStoryComment(storyId);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCommentPost(
      String postId, String comment) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.addCommentPost(postId, comment);
    });
  }

  @override
  Future<Either<Failure, Unit>> addLikeCommentPost(
      String postId, String commentId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.addLikeCommentPost(postId, commentId);
    });
  }

  @override
  Future<Either<Failure, Unit>> addLikePost(String postId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.addLikePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyComment(
      String storyId, String comment) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.addCommentStory(storyId, comment);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyCommentLike(
      String storyId, String commentId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.addLikeCommentStory(storyId, commentId);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyLike(String storyId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.addLikeStory(storyId);
    });
  }

  @override
  Future<Either<Failure, Unit>> modifyPost(
      String postId, String description) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.updatePost(postId, description);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return right(unit);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }
}
