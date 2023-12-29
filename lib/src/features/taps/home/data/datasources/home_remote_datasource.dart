import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> getAllPostsSocket();
  Future<List<StoryModel>> getAllStories();
  Future<Unit> changePostLike(String postId);
  Future<Unit> addPostShare(String postId);
  Future<Unit> deletePost(String postId);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final BaseRepository baseRepository;
  HomeRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<List<PostModel>> getAllPosts() async {
    diox.Response response = await baseRepository.getRoute(
      ApiGateway.getPost,
    );

    List<PostModel> posts = [];

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        posts = rawData.map((e) => PostModel.fromMap(e)).toList();
      },
    );

    return posts;
  }

  @override
  Future<Unit> getAllPostsSocket() async {
    SocketEmit().getAllPosts();
    return Future.value(unit);
  }

    @override
  Future<List<StoryModel>> getAllStories() async {
    diox.Response response = await baseRepository.getRoute(
      ApiGateway.getStory,
    );

    List<StoryModel> stories = [];

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        stories = rawData.map((e) => StoryModel.fromMap(e)).toList();
      },
    );

    return stories;
  }

  @override
  Future<Unit> changePostLike(String postId) {
    SocketEmit().changePostLikeEmit(postId);
    return Future.value(unit);
  }

  @override
  Future<Unit> addPostShare(String postId) {
    SocketEmit().addPostShare(postId);
    return Future.value(unit);
  }

  @override
  Future<Unit> deletePost(String postId) async {
    var body = {
      "postId": postId,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.deletePost,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
