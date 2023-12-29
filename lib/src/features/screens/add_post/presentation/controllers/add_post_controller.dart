import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../../controller/app_controller.dart';
import '../../../../../core/enums/post_enum.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../core/picker/picker.dart';
import '../../../../../core/widgets/app_clouding.dart';
import '../../../../../public/components.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';

import '../../domain/usecases/add_post.dart';

class AddPostController extends GetxController with HandleLoading {
  final AddPostUseCase addPostUseCase;
  AddPostController(
    this.addPostUseCase,
  );

  late TextEditingController descriptionController;

  @override
  void onInit() {
    _assetImagesDevice();
    descriptionController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    imageFileSelected.value = [];
    descriptionController.dispose();
    super.dispose();
  }

  List<AssetEntity> mediaList = [];
  RxList<Map<PostEnum, File>> imageFileSelected = <Map<PostEnum, File>>[].obs;

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 90);
        mediaList = photos;
        update();
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  void selectImage() async {
    File? image = await pickImageFromCamera();
    if (image != null) {
      imageFileSelected.add({
        PostEnum.image: image,
      });
    }
    update();
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      imageFileSelected.add({
        PostEnum.video: video,
      });
    }
  }

  void addFile(File file) {
    imageFileSelected.add({
      PostEnum.image: file,
    });
  }

  void removePhoto(int index) {
    imageFileSelected.removeAt(index);
  }

  List<PostEnum> itemsKey() {
    List<PostEnum> items = [];
    imageFileSelected
        .map(
          (e) => e.forEach(
            (key, value) {
              items.add(key);
            },
          ),
        )
        .toList();
    return items;
  }

  List<File> itemsVal() {
    List<File> items = [];
    imageFileSelected
        .map(
          (e) => e.forEach(
            (key, value) {
              items.add(value);
            },
          ),
        )
        .toList();
    return items;
  }

  FutureOr<void> addPost(
    String description,
    List<Map<PostEnum, File>>? posts,
  ) async {
    showLoading();

    List<String> postsType = [];
    List<String> postsUrl = [];

    if (posts!.isNotEmpty) {
      for (var i = 0; i < itemsKey().length; i++) {
        switch (itemsKey()[i]) {
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

      for (var i = 0; i < itemsVal().length; i++) {
        postsUrl.add(await cloudinaryPublic(itemsVal()[i].path));
      }
    }

    final result = await addPostUseCase(description, postsUrl, postsType);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        imageFileSelected.value = [];
        descriptionController.text = '';
        hideLoading();
        update();
        Components.showSnackBar(
          "added your post",
          title: "Added successfully",
          color: colorPrimary,
        );
        AppNavigator.pop();
        AppGet.homeGet.getAllPosts();
        update();
      },
    );
  }
}
