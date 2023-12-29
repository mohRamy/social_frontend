import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repository/base_home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/post_model.dart';
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
  Future<Either<Failure, Unit>> changePostLike(String postId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.changePostLike(postId);
    });
  }

    @override
  Future<Either<Failure, Unit>> addPostShare(String postId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.addPostShare(postId);
    });
  }

    @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    return await _getMessage(() {
      return baseHomeRemoteDataSource.deletePost(postId);
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
