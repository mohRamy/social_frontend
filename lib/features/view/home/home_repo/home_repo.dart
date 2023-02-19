import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:social_app/core/network/api_constance.dart';
import '../../../../core/enums/post_enum.dart';

import '../../../../core/enums/story_enum.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  final ApiClie apiClient;
  HomeRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchAllPosts() async {
    return await apiClient.getData(ApiConstance.getPost);
  }

  Future<http.Response> updatePost({
    required String postId,
    required String description,
  }) async {
    return await apiClient.postData(
      AppString.POST_UPDATE_URL,
      jsonEncode({
        "postId": postId,
        "desc": description,
      }),
    );
  }

  Future<http.Response> deletePost({
    required String postId,
  }) async {
    return await apiClient.postData(
      AppString.POST_DELETE_URL,
      jsonEncode({
        "postId": postId,
      }),
    );
  }

  Future<http.Response> postLike(String postId) async {
    return await apiClient.postData(
      AppString.POST_LIKE_ADD_URL,
      jsonEncode(
        {
          "postId": postId,
        },
      ),
    );
  }

  Future<http.Response> postComment(
    String postId,
    String comment,
  ) async {
    return await apiClient.postData(
      AppString.POST_COMMENT_ADD_URL,
      jsonEncode(
        {
          "postId": postId,
          "comment": comment,
        },
      ),
    );
  }

  Future<http.Response> fetchAllPostComment(
    String postId,
  ) async {
    return await apiClient
        .getData("${AppString.POST_COMMENT_GET_URL}?postId=$postId");
  }

  Future<http.Response> postCommentLike(
      String postId, String commentId) async {
    return await apiClient.postData(
      AppString.POST_COMMENT_LIKE_URL,
      jsonEncode(
        {
          "postId": postId,
          "commentId": commentId,
        },
      ),
    );
  }

  Future<http.Response> fetchAllStories() async {
    return await apiClient.getData(AppString.STORY_GET_URL);
  }

  Future<http.Response> addStory({
    required List<Map<StoryEnum, File>> story,
  }) async {
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

    return await apiClient.postData(
      AppString.STORY_ADD_URL,
      jsonEncode({
        "storiesUrl": storyCloudinary,
        "storiesType": contactMsg,
      }),
    );
  }

  Future<http.Response> storyLike(String storyId) async {
    return await apiClient.postData(
      AppString.STORY_LIKE_ADD_URL,
      jsonEncode(
        {
          "storyId": storyId,
        },
      ),
    );
  }

  Future<http.Response> storyComment(
    String storyId,
    String comment,
  ) async {
    return await apiClient.postData(
      AppString.STORY_COMMENT_ADD_URL,
      jsonEncode(
        {
          "storyId": storyId,
          "comment": comment,
        },
      ),
    );
  }

  Future<http.Response> fetchAllStoryComment(
    String storyId,
  ) async {
    return await apiClient
        .getData("${AppString.STORY_COMMENT_GET_URL}?storyId=$storyId");
  }

  Future<http.Response> storyCommentLike(
    String storyId,
    String commentId,
  ) async {
    return await apiClient.postData(
      AppString.STORY_COMMENT_LIKE_URL,
      jsonEncode(
        {
          "storyId": storyId,
          "commentId": commentId,
        },
      ),
    );
  }
}