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

  Future<http.Response> postLike(String postId) async {
    return await apiClient.postData(
      AppString.POST_LIKE_URL,
      jsonEncode(
        {
          "postId": postId,
        },
      ),
    );
  }
}
