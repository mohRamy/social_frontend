import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';
import '../../../../core/enums/post_enum.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../../../public/components.dart';
import '../../domain/usecases/add_post.dart';

class PostController extends GetxController with HandleErrorLoading {
  final AddPostUseCase addPostUseCase;
  PostController({
    required this.addPostUseCase,
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

  FutureOr<void> addPost(
    String description,
    List<Map<PostEnum, File>>? posts,
  ) async {
    showLoading();
    List<PostEnum> itemsKey = [];
    List<File> itemsVal = [];

    List<String> postsType = [];

    List<String> postsUrl = [];

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
            postsType.add("image");
            break;
          case PostEnum.video:
            postsType.add("video");
            break;
          case PostEnum.audio:
            postsType.add("audio");
            break;
          case PostEnum.gif:
            postsType.add("GIF");
            break;
          default:
            postsType.add("GIF");
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
        postsUrl.add(res.secureUrl);
      }
    }

    final result = await addPostUseCase(description, postsUrl, postsType);
    result.fold(
      (l) => handleError(l),
      (r) {
        descriptionC.text = '';
        imageFileSelected.clear();
        hideLoading();
        update();
        Components.showSnackBar(
          "added your post",
          title: "Added successfully",
          color: colorPrimary,
        );
      },
    );
  }
}
