import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/enums/message_enum.dart';
import '../post_repo/post_repo.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/post_model.dart';
import '../../../data/models/user_model.dart';

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';

class PostCtrl extends GetxController implements GetxService {
  final PostRepo postRepo;
  PostCtrl({
    required this.postRepo,
  });

  late List<Map<PostEnum, File>> imageFileSelected = []; 
  late TextEditingController descriptionC;

  List<PostModel> posts = [];
  late UserModel user;

  @override
  void onInit() {
    descriptionC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    descriptionC.dispose();
    super.onClose();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void addPost({
    required String description,
    required List<Map<PostEnum, File>> posts,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await postRepo.addPost(
        description: description,
        posts: posts,
      );
      
      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            title: '',
            'Added Post!',
            color: Colors.green,
          );
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void updatePost({
    required String description,
    required String postUrl,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await postRepo.updatePost(
        description: description,
        postUrl: postUrl,
      );

      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            title: '',
            'Modified Post!',
            color: Colors.green,
          );
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void deletePost({
    required String postId,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await postRepo.deletePost(
        postId: postId,
      );

      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            title: '',
            'Deleted Post!',
            color: Colors.green,
          );
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  

}
