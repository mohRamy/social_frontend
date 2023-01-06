import 'dart:convert';

import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  final ApiClient apiClient;
  HomeRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchAllPosts() async {
    return await apiClient.getData(AppString.POST_GET_URL);
  }

  Future<http.Response> updatePost({
    required String description,
    required String postUrl,
  }) async {
    return await apiClient.postData(
      AppString.POST_UPDATE_URL,
      jsonEncode({
        "description": description,
        "postUrl": postUrl,
      }),
    );
  }

  Future<http.Response> deletePost({
    required String postId,
  }) async {
    return await apiClient.postData(
      AppString.POST_DELETE_URL,
      jsonEncode({
        "id": postId,
      }),
    );
  }

  Future<http.Response> postLike(String postId, int isAdd) async {
    return await apiClient.postData(
      AppString.POST_LIKE_ADD_URL,
      jsonEncode(
        {
          "postId": postId,
          "isAdd": isAdd,
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
      String postId, String commentId, int isAdd) async {
    return await apiClient.postData(
      AppString.POST_COMMENT_LIKE_URL,
      jsonEncode(
        {
          "postId": postId,
          "commentId": commentId,
          "isAdd": isAdd,
        },
      ),
    );
  }

  Future<http.Response> fetchAllStories() async {
    return await apiClient.getData(AppString.STORY_GET_URL);
  }
}
