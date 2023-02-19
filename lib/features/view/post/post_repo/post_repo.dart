import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

import '../../../../core/enums/post_enum.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';


class PostRepo {
  final ApiClie apiClient;
  PostRepo({
    required this.apiClient,
  });

  Future<http.Response> addPost({
    required String description,
    List<Map<PostEnum, File>>? posts,
  }) async {
    List<PostEnum> itemsKey = [];
    List<File> itemsVal = [];

    List<String> contactMsg = [];

    List<String> postCloudinary = [];

    if (posts!.isNotEmpty) {
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

    int random = Random().nextInt(1000);

    final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
    
    for (var i = 0; i < itemsVal.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          itemsVal[i].path,
          folder: "$random",
        ),
      );
      postCloudinary.add(res.secureUrl);
    }
    }

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
