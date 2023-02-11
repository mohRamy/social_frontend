import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/enums/post_enum.dart';
import '../post_repo/post_repo.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';

class PostCtrl extends GetxController implements GetxService {
  final PostRepo postRepo;
  PostCtrl({
    required this.postRepo,
  });

  late List<Map<PostEnum, File>> imageFileSelected = []; 
  late TextEditingController descriptionC;


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

  

}
