import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/home_remote_datasource.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/story.dart';
import '../../domain/repository/base_home_repository.dart';

import '../../../../core/error/exceptions.dart';

typedef Future<Unit> GetMessage();
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
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> postComment(
      String postId, String comment) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.postComment(postId, comment);
    });
  }

  @override
  Future<Either<Failure, Unit>> postCommentLike(
      String postId, String commentId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.postCommentLike(postId, commentId);
    });
  }

  @override
  Future<Either<Failure, Unit>> postLike(String postId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.postLike(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyComment(
      String storyId, String comment) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.storyComment(storyId, comment);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyCommentLike(
      String storyId, String commentId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.storyCommentLike(storyId, commentId);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyLike(String storyId) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.storyLike(storyId);
    });
  }

  @override
  Future<Either<Failure, Unit>> modifyPost(
      String postId, String description) async {
    return await _getMessage((){
      return baseHomeRemoteDataSource.modifyPost(postId, description);
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
      return left(OfflineFailure(message: "Offline failure"));
    }
  }
}
