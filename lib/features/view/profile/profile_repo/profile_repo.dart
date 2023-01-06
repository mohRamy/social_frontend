import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';
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
    required File? image,
  }) async {
    String photoCloudinary =
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
    if (image != null) {

      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          folder: image.path,
        ),
      );
      photoCloudinary = res.secureUrl;
    }
    return await apiClient.postData(
      AppString.PROFILE_BGIMAGE_URL,
      jsonEncode(
        {
          "image": photoCloudinary,
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
