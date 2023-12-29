import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/usecases/update_post.dart';

import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../public/components.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';

class UpdatePostController extends GetxController with HandleLoading {
  final UpdatePostUseCase updatePostUseCase;
  UpdatePostController(
    this.updatePostUseCase,
  );

  late TextEditingController descriptionC;

  @override
  void onInit() {
    descriptionC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    descriptionC.dispose();
    super.dispose();
  }

  void initTextCtrl(String? postDesc) {
    descriptionC.text = postDesc ?? "";
    update();
  }

  FutureOr<void> udpatePost(String postId, String description) async {
    showLoading();

    final result = await updatePostUseCase(postId, description);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        hideLoading();
        update();
        Components.showSnackBar(
          "Modifed your post",
          title: "Added Modify",
          color: colorPrimary,
        );
        // getAllPosts();
        // AppGet.profileGet.getUserPosts();
        AppNavigator.pop();
      },
    );
  }
}
