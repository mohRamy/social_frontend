import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:social_app/features/home/data/models/comment_model.dart';
import 'package:social_app/features/home/data/models/post_model.dart';
import 'package:social_app/features/home/data/models/story_model.dart';

import '../../../../core/enums/story_enum.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constance.dart';
import '../../../../core/utils/constants/state_handle.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/story.dart';

abstract class BaseHomeRemoteDataSource {
  // post
  Future<List<Post>> getAllPosts();
  Future<Unit> updatePost(String postId, String description);
  Future<Unit> deletePost(String postId);
  Future<Unit> postLike(String postId);
  Future<Unit> postComment(String postId, String comment);
  Future<List<Comment>> getAllPostComment(String postId);
  Future<Unit> postCommentLike(String postId, String commentId);
  // story
  Future<List<Story>> getAllStories();
  Future<Unit> addStory(
    List<Map<StoryEnum, File>> story,
  );
  Future<List<Comment>> getAllStoryComment(String storyId);
  Future<Unit> storyLike(String storyId);
  Future<Unit> storyComment(String storyId, String comment);
  Future<Unit> storyCommentLike(String storyId, String commentId);
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  final ApiClient apiClient;
  HomeRemoteDataSource(
    this.apiClient,
  );

  @override
  Future<Unit> addStory(List<Map<StoryEnum, File>> story) async {
    List<StoryEnum> itemsKey = [];
    List<File> itemsVal = [];

    List<String> contactMsg = [];

    story
        .map((e) => e.forEach((key, value) {
              itemsKey.add(key);
            }))
        .toList();
    story
        .map((e) => e.forEach((key, value) {
              itemsVal.add(value);
            }))
        .toList();

    for (var i = 0; i < itemsKey.length; i++) {
      switch (itemsKey[i]) {
        case StoryEnum.image:
          contactMsg.add("image");
          break;
        case StoryEnum.video:
          contactMsg.add("video");
          break;
        default:
          contactMsg.add("image");
      }
    }

    int random = Random().nextInt(1000);

    final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
    List<String> storyCloudinary = [];
    for (var i = 0; i < itemsVal.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          itemsVal[i].path,
          folder: "$random",
        ),
      );
      storyCloudinary.add(res.secureUrl);
    }
    http.Response res = await apiClient.postData(
      ApiConstance.addStory,
      jsonEncode({
        "storiesUrl": storyCloudinary,
        "storiesType": contactMsg,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> deletePost(String postId) async {
    http.Response res = await apiClient.postData(
      ApiConstance.deletePost,
      jsonEncode({
        "postId": postId,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<List<Comment>> getAllPostComment(String postId) async {
    http.Response res = await apiClient.getData(
      "${ApiConstance.getCommentPost}?postId=$postId",
    );
    List<Comment> postComments = [];
    stateErrorHandle(
      res: res,
      onSuccess: () {
        postComments = [];
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          postComments.add(
            CommentModel.fromJson(
              jsonEncode(
                jsonDecode(
                  res.body,
                )[i],
              ),
            ),
          );
        }
      },
    );
    return postComments;
  }

  @override
  Future<List<Post>> getAllPosts() async {
    http.Response res = await apiClient.getData(
      ApiConstance.getPost,
    );
    List<Post> posts = [];
    stateErrorHandle(
      res: res,
      onSuccess: () {
        posts = [];
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          posts.add(
            PostModel.fromJson(
              jsonEncode(
                jsonDecode(
                  res.body,
                )[i],
              ),
            ),
          );
        }
      },
    );
    return posts;
  }

  @override
  Future<List<Story>> getAllStories() async {
    http.Response res = await apiClient.getData(
      ApiConstance.getStory,
    );
    List<Story> stories = [];
    stateErrorHandle(
      res: res,
      onSuccess: () {
        stories = [];
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          stories.add(
            StoryModel.fromJson(
              jsonEncode(
                jsonDecode(
                  res.body,
                )[i],
              ),
            ),
          );
        }
      },
    );
    return stories;
  }

  @override
  Future<List<Comment>> getAllStoryComment(String storyId) async {
    http.Response res = await apiClient
        .getData("${ApiConstance.getCommentStory}?storyId=$storyId");
    List<Comment> commentStory = [];
    stateErrorHandle(
      res: res,
      onSuccess: () {
        commentStory = [];
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          commentStory.add(
            CommentModel.fromJson(
              jsonEncode(
                jsonDecode(
                  res.body,
                )[i],
              ),
            ),
          );
        }
      },
    );
    return commentStory;
  }

  @override
  Future<Unit> postComment(String postId, String comment) async {
    http.Response res = await apiClient.postData(
      ApiConstance.addCommentPost,
      jsonEncode({
        "postId": postId,
        "comment": comment,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> postCommentLike(String postId, String commentId) async {
    http.Response res = await apiClient.postData(
      ApiConstance.addLikeCommentPost,
      jsonEncode({
        "postId": postId,
        "commentId": commentId,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> postLike(String postId) async {
    http.Response res = await apiClient.postData(
      ApiConstance.addLikePost,
      jsonEncode({
        "postId": postId,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> storyComment(String storyId, String comment) async {
    http.Response res = await apiClient.postData(
      ApiConstance.addCommentStory,
      jsonEncode({
        "storyId": storyId,
        "comment": comment,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> storyCommentLike(String storyId, String commentId) async {
    http.Response res = await apiClient.postData(
      ApiConstance.addLikeCommentStory,
      jsonEncode({
        "storyId": storyId,
        "commentId": commentId,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> storyLike(String storyId) async {
    http.Response res = await apiClient.postData(
      ApiConstance.addLikeStory,
      jsonEncode({
        "storyId": storyId,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> updatePost(String postId, String description) async {
    http.Response res = await apiClient.postData(
      ApiConstance.updatePost,
      jsonEncode({
        "postId": postId,
        "desc": description,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }
}
