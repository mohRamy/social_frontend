import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';

import '../../../../core/enums/story_enum.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';
import 'package:http/http.dart' as http;

class StoryRepo {
  final ApiClient apiClient;
  StoryRepo({
    required this.apiClient,
  });

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

    String createdAt = DateTime.now().toIso8601String(); 

    return await apiClient.postData(
      AppString.STORY_ADD_URL,
      jsonEncode({
        "storiesUrl": storyCloudinary,
        "storiesType": contactMsg,
        "createdAt": createdAt,
      }),
    );
  }

  Future<http.Response> storyLike(String storyId, int isAdd) async {
    return await apiClient.postData(
      AppString.STORY_LIKE_ADD_URL,
      jsonEncode(
        {
          "storyId": storyId,
          "isAdd": isAdd,
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
    int isAdd,
  ) async {
    return await apiClient.postData(
      AppString.STORY_COMMENT_LIKE_URL,
      jsonEncode(
        {
          "storyId": storyId,
          "commentId": commentId,
          "isAdd": isAdd,
        },
      ),
    );
  }
}