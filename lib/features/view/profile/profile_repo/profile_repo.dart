import 'dart:convert';

import 'package:get/get.dart';
import '../../../../controller/user_ctrl.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../data/api/api_client.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  final ApiClient apiClient;
  ProfileRepo({
    required this.apiClient,
  });

  Future<http.Response> followUser({
    required String userId,
  }) async {
    return await apiClient.postData(
      AppString.PROFILE_FOLLOW_URL,
      jsonEncode(
        {
          "userId": userId,
        },
      ),
    );
  }

  Future<http.Response> fetchMyPost({
    required String userId,
  }) async {
    return await apiClient
        .getData("${AppString.MYPOST_GET_URL}?userId=$userId");
  }

  Future<http.Response> modifyBGImage({
    required String image,
  }) async {
    return await apiClient.postData(
      AppString.PROFILE_BGIMAGE_URL,
      jsonEncode(
        {
          "image": image,
        },
      ),
    );
  }

  Future<http.Response> modifyImage({
    required String image,
  }) async {
    return await apiClient.postData(
      AppString.PROFILE_IMAGE_URL,
      jsonEncode(
        {
          "image": image,
        },
      ),
    );
  }
}
