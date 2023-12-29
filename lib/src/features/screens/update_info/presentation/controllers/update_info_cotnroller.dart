import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_app/src/controller/app_controller.dart';
import 'package:social_app/src/core/error/handle_error_loading.dart';
import 'package:social_app/src/features/screens/update_info/domain/usecases/update_info.dart';
import 'package:social_app/src/routes/app_pages.dart';

import '../../../../../core/picker/picker.dart';
import '../../../../../core/widgets/app_clouding.dart';
import '../../../../../public/components.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../themes/app_colors.dart';
import '../../../auth/data/models/auth_model.dart';

class UpdateInfoController extends GetxController with HandleLoading {
  final UpdateInfoUseCase udpateInfoUseCase;
    UpdateInfoController(
    this.udpateInfoUseCase,
);

  late TextEditingController nameC;
  late TextEditingController bioC;
  late TextEditingController emailC;
  late TextEditingController addressC;
  late TextEditingController phoneC;

  final AuthModel userInfo = UserLocal().getUser()!;

  @override
  void onInit() {
    nameC = TextEditingController(text: userInfo.name);
    bioC = TextEditingController(text: userInfo.bio);
    emailC = TextEditingController(text: userInfo.email);
    addressC = TextEditingController(text: userInfo.address);
    phoneC = TextEditingController(text: userInfo.phone);
    super.onInit();
  }

  @override
  void dispose() {
    nameC.dispose();
    bioC.dispose();
    emailC.dispose();
    addressC.dispose();
    phoneC.dispose();
    super.dispose();
  }

  File? backgroundImageFile;
  File? photoFile;

  void selectImageFromCamera(bool isPhoto) async {
    File? image = await pickImageFromCamera();
    if (image != null) {
      if (isPhoto) {
        photoFile = image;
      } else {
        backgroundImageFile = image;
      }
    }
    AppNavigator.pop();
    update();
  }

  void selectImageFromGallery(bool isPhoto) async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      if (isPhoto) {
        photoFile = image;
      } else {
        backgroundImageFile = image;
      }
    }
    AppNavigator.pop();
    update();
  }

    FutureOr<void> updateUserInfo(
    String name,
    String bio,
    String email,
    String address,
    String phone,
    File? photo,
    File? backgroundImage,
  ) async {
    showLoading();
    update();
    String photoCloud = '';
    if (photo != null) {
      photoCloud = await cloudinaryPublic(photo.path);
    } else {
      photoCloud = AppGet.authGet.userData!.photo;
    }
    
    String backgroundImageCloud = '';
    if (backgroundImage != null) {
      backgroundImageCloud = await cloudinaryPublic(backgroundImage.path);
    } else {
      backgroundImageCloud = AppGet.authGet.userData!.backgroundImage;
    }

    AuthModel userInfo = AuthModel(
      id: "",
      name: name,
      email: email,
      bio: bio,
      friends: const [],
      friendRequests: const [],
      photo: photoCloud,
      backgroundImage: backgroundImageCloud,
      phone: phone,
      password: "",
      address: address,
      type: "",
      private: false,
      token: "",
      fcmToken: "",
      isOnline: false,
    );

    final result = await udpateInfoUseCase(userInfo);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        hideLoading();
        update();
        Components.showSnackBar(
          "Updated Your Information!",
          title: "Successful",
          color: colorPrimary,
        );
        AppNavigator.pop();
        AppGet.authGet.getUserInfo();
        update();
      },
    );

    update();
  }

  void updatedUserInfo(dynamic data){
    AuthModel userInfo = AuthModel.fromMap(data);
    AppGet.authGet.userData = userInfo;
    UserLocal().saveUser(userInfo);
  }
}
