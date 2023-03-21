import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/usecases/get_my_data.dart';
import '../../domain/usecases/get_user_data.dart';
import '../../domain/usecases/is_token_valid.dart';
import '../../domain/usecases/sign_in.dart';

import '../../../../config/routes/app_pages.dart';
import 'user_controller.dart';
import '../../../../core/error/handle_error_loading.dart';
import '../../../../core/utils/app_component.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../helper/dependencies.dart' as dep;
import '../../domain/entities/auth.dart';
import '../../domain/usecases/sign_up.dart';

class AuthController extends GetxController with HandleErrorLoading {
  final SignInAuthUsecase signInAuthUsecase;
  final SignUpAuthUsecase signUpAuthUsecase;
  final IsTokenValidAuthUsecase isTokenValidAuthUsecase;
  final GetMyDataAuthUsecase getMyDataAuthUsecase;
  final GetUserDataAuthUsecase getUserDataAuthUsecase;
  final ApiClient apiClient;
  GetStorage box;

  AuthController({
    required this.signInAuthUsecase,
    required this.signUpAuthUsecase,
    required this.isTokenValidAuthUsecase,
    required this.getMyDataAuthUsecase,
    required this.getUserDataAuthUsecase,
    required this.apiClient,
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

    Auth? auth;

    await FirebaseMessaging.instance.getToken().then((value){
    auth = Auth(
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
      fcmtoken: value??"",
    );
  });

    final result = await signUpAuthUsecase(auth!);

    result.fold(
      (l) => AppComponents.showCustomSnackBar(l.message),
      (r) => AppComponents.showCustomSnackBar("Logged up Log in now", title: "", color: Colors.green),
    );
  }

  void signInUser(
    String email,
    String password,
  ) async {
    final result = await signInAuthUsecase(email, password);
    result.fold(
      (l) { 
        AppComponents.showCustomSnackBar(l.message);
        },
      (r) async {
        await dep.init();
        saveUserToken(r.token);
        Get.find<UserController>().setUserFromModel(r);
        box.write(AppString.typeKey, r.type);

        if (Get.find<UserController>().user.type == 'user') {
          Get.offNamedUntil(Routes.NAV_USER_SCREEN, (route) => false);
        } else {
          Get.offNamedUntil(Routes.SIGN_UP, (route) => false);
        }
      },
    );
  }

  void getMyData() async {
    final token = box.read(AppString.token);
    if (token == null) {
      box.write(AppString.token, '');
    }

    bool response = true;

    final tokenResult = await isTokenValidAuthUsecase();
    tokenResult.fold(
      (l) => AppComponents.showCustomSnackBar(l.message),
      (r) => response = r,
    );

    if (response == true) {
      final result = await getMyDataAuthUsecase();
      result.fold(
        (l) => AppComponents.showCustomSnackBar(l.message),
        (r) {
          UserController userController = Get.find<UserController>();
          userController.setUserFromModel(r);
        },
      );
    }
  }

  Future<Auth> getUserData(String userId) async {
    Auth? userData;

    final result = await getUserDataAuthUsecase(userId);

    result.fold(
      (l) => AppComponents.showCustomSnackBar(l.message),
      (r) => userData = r,
    );

    return userData!;
  }

  // save user token
  void saveUserToken(String token) {
    apiClient.token = token;
    apiClient.updateHeaders(token);
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
    apiClient.token = '';
    apiClient.updateHeaders('');
    return true;
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
