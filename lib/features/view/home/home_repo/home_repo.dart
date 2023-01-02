import 'dart:convert';

import 'package:get/get.dart';
import 'package:social_app/controller/user_ctrl.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/user_model.dart';

class HomeRepo {
  final ApiClient apiClient;
  HomeRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchAllPosts() async {
    return await apiClient.getData(AppString.POST_GET_URL);
  }

  Future<http.Response> postLike(String postId, int isAdd) async {
    print('ooooooooooooooooooooooo');
    return await apiClient.postData(
      AppString.POST_ADD_LIKE_URL,
      jsonEncode(
        {
          "postId": postId,
          "isAdd": isAdd,
          "email": Get.find<UserCtrl>().user.email,
        },
      ),
    );
  }

  Future<http.Response> postComment(
    String postId,
    String comment,
  ) async {
    return await apiClient.postData(
      AppString.POST_ADD_COMMENT_URL,
      jsonEncode(
        {
          "postId": postId,
          "comment": comment,
        },
      ),
    );
  }

  Future<http.Response> fetchAllComment(
    String postId,
  ) async {
    return await apiClient.getData("${AppString.POST_GET_COMMENT_URL}?postId=$postId");
  }

  // Future<http.Response> postDeleteLike(String postId) async {
  //   return await apiClient.postData(
  //     AppString.POST_DELETE_LIKE_URL,
  //     jsonEncode(
  //       {
  //         "postId": postId,
  //       },
  //     ),
  //   );
  // }
}
