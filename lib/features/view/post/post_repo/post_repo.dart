import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../controller/user_ctrl.dart';
import '../../../../core/enums/post_enum.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';


class PostRepo {
  final ApiClient apiClient;
  PostRepo({
    required this.apiClient,
  });

  Future<http.Response> addPost({
    required String description,
    required List<Map<PostEnum, File>> posts,
  }) async {
    List<PostEnum> itemsKey = [];
    List<File> itemsVal = [];

    List<String> contactMsg = [];

    posts
        .map((e) => e.forEach((key, value) {
              itemsKey.add(key);
            }))
        .toList();
    posts
        .map((e) => e.forEach((key, value) {
              itemsVal.add(value);
            }))
        .toList();

    for (var i = 0; i < itemsKey.length; i++) {
      switch (itemsKey[i]) {
        case PostEnum.image:
          contactMsg.add("image");
          break;
        case PostEnum.video:
          contactMsg.add("video");
          break;
        case PostEnum.audio:
          contactMsg.add("audio");
          break;
        case PostEnum.gif:
          contactMsg.add("GIF");
          break;
        default:
          contactMsg.add("GIF");
      }
    }

    final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
    List<String> postCloudinary = [];
    for (var i = 0; i < itemsVal.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          itemsVal[i].path,
          folder: description,
        ),
      );
      postCloudinary.add(res.secureUrl);
    }

    print(Get.find<UserCtrl>().user.id);
    return await apiClient.postData(
      AppString.POST_ADD_URL,
      jsonEncode({
        "description": description,
        "postsUrl": postCloudinary,
        "postsType": contactMsg,
      }),
    );
  }

  
}
