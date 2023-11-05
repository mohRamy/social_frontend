import 'package:dartz/dartz.dart';

import 'package:social_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repository/base_home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/story_model.dart';

typedef GetMessage = Future<Unit> Function();

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource baseHomeRemoteDataSource;
  final HomeLocalDataSource baseHomeLocalDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl(
    this.baseHomeRemoteDataSource,
    this.baseHomeLocalDataSource,
    this.networkInfo,
  );
  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final List<PostModel> result =
            await baseHomeRemoteDataSource.getAllPosts();
        baseHomeLocalDataSource.saveAllPosts(result);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      try {
        final List<PostModel> result = baseHomeLocalDataSource.getAllPosts();
        return Right(result);
      } on LocalException catch (failure) {
        return Left(LocalFailure(message: failure.messageError));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> getAllPostsSocket() async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.getAllPostsSocket();
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(
    String postId,
    String description,
  ) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.updatePost(postId, description);
    });
  }

  @override
  Future<Either<Failure, Unit>> addLikePost(String postId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addLikePost(postId);
    });
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllPostComment(
    String postId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllPostComment(postId);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCommentPost(
      String postId, String comment) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addCommentPost(postId, comment);
    });
  }

  @override
  Future<Either<Failure, Unit>> addLikeCommentPost(
      String postId, String commentId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addLikeCommentPost(postId, commentId);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, List<StoryModel>>> getAllStories() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseHomeRemoteDataSource.getAllStories();
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addStory(
      List<String> storiesUrl, List<String> storiesType) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addStory(storiesUrl, storiesType);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyLike(String storyId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addLikeStory(storyId);
    });
  }

  @override
  Future<Either<Failure, Unit>> storyComment(
      String storyId, String comment) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addCommentStory(storyId, comment);
    });
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllStoryComment(
      String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await baseHomeRemoteDataSource.getAllStoryComment(storyId);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> storyCommentLike(
      String storyId, String commentId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addLikeCommentStory(storyId, commentId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return const Right(unit);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }
}
