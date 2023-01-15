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

  List<PostModel> myPost = [];

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

  void fetchMyPost(
    String userId,
  ) async {
    try {
      http.Response res = await profileRepo.fetchMyPost(
        userId: userId,
      );

      stateHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            myPost.add(
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
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    update();
  }

  void modifyBGImage(
    File? image,
  ) async {
    try {
      http.Response res = await profileRepo.modifyBGImage(
        image: image,
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

  void modifyImage(
    String image,
  ) async {
    try {
      http.Response res = await profileRepo.modifyImage(
        image: image,
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
}
