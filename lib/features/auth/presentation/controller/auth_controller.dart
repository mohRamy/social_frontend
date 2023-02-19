import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:social_app/core/network/api_client.dart';
import 'package:social_app/features/auth/data/models/auth_model.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../controller/user_ctrl.dart';
import '../../../../core/error/handle_error_loading.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../helper/dependencies.dart' as dep;
import '../../domain/entities/auth.dart';
import '../../domain/repository/base_auth_repository.dart';

class AuthController extends GetxController with HandleErrorLoading {
  final BaseAuthRepository authRepository;
  final ApiClient apiClien;
  GetStorage box;
  AuthController({
    required this.authRepository,
    required this.apiClien,
    required this.box,
  });

  TextEditingController emailIC = TextEditingController();
  TextEditingController passwordIC = TextEditingController();

  TextEditingController emailUC = TextEditingController();
  TextEditingController passwordUC = TextEditingController();
  TextEditingController nameUC = TextEditingController();
  TextEditingController phoneUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailIC.dispose();
    passwordIC.dispose();

    emailUC.dispose();
    passwordUC.dispose();
    nameUC.dispose();
    phoneUC.dispose();
  }

  void signUpUser({
    required String name,
    required String email,
    required String password,
    required File? photo,
  }) async {
    showLoading();

    String photoCloudinary =
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

    if (photo != null) {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      int random = Random().nextInt(1000);

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          photo.path,
          folder: "$name $random",
        ),
      );
      photoCloudinary = res.secureUrl;
    }

    final auth = Auth(
      id: "",
      name: name,
      email: email,
      bio: "",
      followers: const [],
      following: const [],
      photo: photoCloudinary,
      backgroundImage: "",
      phone: "",
      password: password,
      address: "",
      type: "",
      private: false,
      token: "",
    );

    final result = await authRepository.signUp(auth);

    result.fold(
      (l) => handleError(l),
      (r) => unit,
    );

    hideLoading();
  }

  void signInUser(
    String email,
    String password,
  ) async {
    showLoading();
    final result = await authRepository.signIn(email, password);
    result.fold(
      (l) => handleError(l),
      (r) async {
        await dep.init();
        saveUserToken(r.token);
        Get.find<UserCtrl>().setUserFromModel(r);
        box.write(AppString.typeKey, r.type);

        if (Get.find<UserCtrl>().user.type == 'user') {
          Get.offNamedUntil(Routes.NAV_USER_SCREEN, (route) => false);
        } else {
          Get.offNamedUntil(Routes.SIGN_UP, (route) => false);
        }
      },
    );

    hideLoading();
  }

  void getMyData() async {
    final token = box.read(AppString.token);
    if (token == null) {
      box.write(AppString.token, '');
    }

    bool response = true;

    final tokenResult = await authRepository.isTokenValid();
    tokenResult.fold((l) => handleError, (r) => response = r);

    if (response == true) {
      final result = await authRepository.getMyData();
      result.fold((l) => handleError, (r) {
        UserCtrl userController = Get.find<UserCtrl>();
        userController.setUserFromModel(r);
      });
    }
  }

  Future<Auth> getUserData(String userId) async {
    Auth? userData;
    showLoading();

    final result = await authRepository.getUserData(userId);

    result.fold((l) => handleError, (r) => userData = r);

    hideLoading();
    return userData!;
  }

  // save user token
  void saveUserToken(String token) {
    apiClien.token = token;
    apiClien.updateHeaders(token);
    box.write(AppString.token, token);
  }

  String getUserToken() {
    return box.read(AppString.token) ?? '';
  }

  String getUserType() {
    return box.read(AppString.typeKey) ?? '';
  }

  bool userLoggedIn() {
    return box.hasData(AppString.token);
  }

  bool clearSharedData() {
    box.remove(AppString.token);
    apiClien.token = '';
    apiClien.updateHeaders('');
    return true;
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
