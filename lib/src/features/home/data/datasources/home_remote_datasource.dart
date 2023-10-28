import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import 'package:social_app/src/services/socket/socket_emit.dart';

import '../../../../public/api_gateway.dart';
import '../../../../public/constants.dart';
import '../../../../resources/base_repository.dart';
import '../models/comment_model.dart';
import '../models/story_model.dart';

import '../../domain/entities/comment.dart';
import '../../domain/entities/story.dart';

abstract class HomeRemoteDataSource {
  // post
  Future<Unit> getAllPosts();
  Future<Unit> updatePost(String postId, String description);
  Future<Unit> deletePost(String postId);
  Future<Unit> addLikePost(String postId);
  Future<Unit> addCommentPost(String postId, String comment);
  Future<List<Comment>> getAllPostComment(String postId);
  Future<Unit> addLikeCommentPost(String postId, String commentId);
  // story
  Future<List<Story>> getAllStories();
  Future<Unit> addStory(List<String> storiesUrl, List<String> storiesType);
  Future<List<Comment>> getAllStoryComment(String storyId);
  Future<Unit> addLikeStory(String storyId);
  Future<Unit> addCommentStory(String storyId, String comment);
  Future<Unit> addLikeCommentStory(String storyId, String commentId);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final BaseRepository baseRepository;
  HomeRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> addStory(
      List<String> storiesUrl, List<String> storiesType) async {
    var body = {
      "storiesUrl": storiesUrl,
      "storiesType": storiesType,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.addStory,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

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

  @override
  Future<List<Comment>> getAllPostComment(String postId) async {
    diox.Response response = await baseRepository.getRoute(
      "${ApiGateway.getCommentPost}?postId=$postId",
    );

    List<Comment> postComments = [];

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        postComments = rawData.map((e) => CommentModel.fromMap(e)).toList();
      },
    );

    return postComments;
  }

  @override
  Future<Unit> getAllPosts() {
    SocketEmit().getAllPosts();
    return Future.value(unit);
    // diox.Response response = await baseRepository.getRoute(
    //   ApiGateway.getPost,
    // );

    // List<Post> posts = [];

    // AppConstants().handleApi(
    //   response: response,
    //   onSuccess: () {
    //     List rawData = response.data;
    //     posts = rawData.map((e) => PostModel.fromMap(e)).toList();
    //   },
    // );
  }

  @override
  Future<List<Story>> getAllStories() async {
    diox.Response response = await baseRepository.getRoute(
      ApiGateway.getStory,
    );

    List<Story> stories = [];

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
  Future<List<Comment>> getAllStoryComment(String storyId) async {
    diox.Response response = await baseRepository.getRoute(
      "${ApiGateway.getCommentStory}?storyId=$storyId",
    );

    List<Comment> commentStory = [];

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        commentStory = rawData.map((e) => CommentModel.fromMap(e)).toList();
      },
    );

    return commentStory;
  }

  @override
  Future<Unit> addCommentPost(String postId, String comment) {
    SocketEmit().addCommentPostEmit(postId, comment);
    return Future.value(unit);
  }

  @override
  Future<Unit> addLikeCommentPost(String postId, String commentId) {
    SocketEmit().changeLikeCommentPostEmit(postId, commentId);
    return Future.value(unit);
  }

  @override
  Future<Unit> addLikePost(String postId) {
    SocketEmit().changeLikePostEmit(postId);
    return Future.value(unit);
  }

  @override
  Future<Unit> addCommentStory(String storyId, String comment) async {
    var body = {
      "storyId": storyId,
      "comment": comment,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.addCommentStory,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> addLikeCommentStory(String storyId, String commentId) async {
    var body = {
      "storyId": storyId,
      "commentId": commentId,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.addLikeCommentStory,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> addLikeStory(String storyId) async {
    var body = {
      "storyId": storyId,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.addLikeStory,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> updatePost(String postId, String description) async {
    var body = {
      "postId": postId,
      "desc": description,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.updatePost,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
