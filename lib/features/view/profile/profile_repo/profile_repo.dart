import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/user_ctrl.dart';
import 'package:social_app/features/data/models/user_model.dart';

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

  Future<http.Response> fetchUserPost({
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
      AppString.PROFILE_MODIFY_URL,
      jsonEncode(
        {
          "image": photoCloudinary,
        },
      ),
    );
  }

  Future<http.Response> modifyUserData({
    required String name,
    required String bio,
    required String email,
    required String address,
    required String phone,
    required File? photo,
    required File? backgroundImage,
  }) async {
    String photoCloud = '';
    if (photo != null) {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      int random = Random().nextInt(1000);

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          photo.path,
          folder: "$name $random",
        ),
      );
      photoCloud = res.secureUrl;
    }else{
      photoCloud = Get.find<UserCtrl>().user.photo;
    }

    String backgroundImageCloud = '';
    if (backgroundImage != null) {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
  
      int random = Random().nextInt(1000);

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          backgroundImage.path,
          folder: "$name $random",
        ),
      );
      backgroundImageCloud = res.secureUrl;
    }else{
      backgroundImageCloud = Get.find<UserCtrl>().user.backgroundImage;
    }

    UserModel userData = UserModel(
      id: "",
      name: name,
      email: email,
      bio: bio,
      followers: [],
      following: [],
      photo: photoCloud,
      backgroundImage: backgroundImageCloud,
      phone: phone,
      password: "",
      address: address,
      type: "",
      private: false,
      token: "",
    );
    return await apiClient.postData(
      AppString.PROFILE_MODIFY_URL,
      userData.toJson(),
    );
  }

  Future<http.Response> deleteFollower({
    required String followerId,
  }) async {
    return await apiClient.postData(
      AppString.PROFILE_MODIFY_URL,
      jsonEncode(
        {
          "followerId": followerId,
        },
      ),
    );
  }

  Future<http.Response> deleteFollowing({
    required String followingId,
  }) async {
    return await apiClient.postData(
      AppString.PROFILE_MODIFY_URL,
      jsonEncode(
        {
          "followingId": followingId,
        },
      ),
    );
  }

  Future<http.Response> privateAccount() async {
    return await apiClient.updateData(
      AppString.PROFILE_PRIVATE_URL,
    );
  }

  Future<http.Response> changePassword({
    required String currentPassword, 
    required String newPassword
    }) async {
    return await apiClient.postData(
      AppString.PROFILE_CHAGNE_PASSWORD_URL,
      jsonEncode(
        {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        },
      ),
    );
  }
}
