import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/post_model.dart';

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../profile_repo/profile_repo.dart';

class ProfileCtrl extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileCtrl({
    required this.profileRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void followUser(
    String userId,
  ) async {
    try {
      http.Response res = await profileRepo.followUser(
        userId: userId,
      );
      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar("Success", color: Colors.green);
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    update();
  }

  Future<List<PostModel>> fetchUserPost(
    String userId,
  ) async {
    List<PostModel> userPost = [];

    http.Response res = await profileRepo.fetchUserPost(
      userId: userId,
    );
    stateHandle(
      res: res,
      onSuccess: () {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          userPost.add(
            PostModel.fromJson(
              jsonEncode(
                jsonDecode(
                  res.body,
                )[i],
              ),
            ),
          );
        }
      },
    );
    return userPost;
  }

  void modifyUserData(
    String name,
    String bio,
    String email,
    String address,
    String phone,
    File? photo,
    File? backgroundImage,
  ) async {
    try {
      http.Response res = await profileRepo.modifyUserData(
        name: name,
        bio: bio,
        email: email,
        address: address,
        phone: phone,
        photo: photo,
        backgroundImage: backgroundImage,
      );
      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar("Success", color: Colors.green);
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    update();
  }

  void deleteFollower(
    String followerId,
  ) async {
    try {
      http.Response res = await profileRepo.deleteFollower(
        followerId: followerId,
      );
      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar("Success", color: Colors.green);
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    update();
  }

  void deleteFollowing(
    String followingId,
  ) async {
    try {
      http.Response res = await profileRepo.deleteFollowing(
        followingId: followingId,
      );
      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar("Success", color: Colors.green);
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    update();
  }

  void privateAccount() async {
    try {
      http.Response res = await profileRepo.privateAccount();
      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar("Success", color: Colors.green);
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    update();
  }

  void changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      http.Response res = await profileRepo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar("Success", color: Colors.green);
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    update();
  }
}
