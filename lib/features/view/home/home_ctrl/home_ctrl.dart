import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_repo/home_repo.dart';

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../data/models/post_model.dart';
import 'package:http/http.dart' as http;

class HomeCtrl extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeCtrl({
    required this.homeRepo,
  });

  List<PostModel> posts = [];

  late TextEditingController commentController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    fetchAllPosts();
    commentController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    commentController.clear();
    commentController.dispose();
    super.onClose();
  }

  void fetchAllPosts() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.fetchAllPosts();

      stateHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            posts.add(
              PostModel.fromMap(
                  jsonDecode(res.body)[i],
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void postLike(
    String postId,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.postLike(postId);

      stateHandle(
        res: res,
        onSuccess: () {},
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }


}
