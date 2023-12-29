import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/picker/picker.dart';
import '../../../../../core/widgets/app_clouding.dart';
import '../../../../../services/firebase_messaging/handle_messaging.dart';

import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../public/components.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../data/models/auth_model.dart';
import '../../domain/usecases/add_user_fcm_token.dart';
import '../../domain/usecases/get_user_info.dart';
import '../../domain/usecases/get_user_info_by_id.dart';
import '../../domain/usecases/is_token_valid.dart';
import '../../domain/usecases/is_user_online.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';

class AuthController extends GetxController with HandleLoading {
  final LoginAuthUsecase loginAuthUsecase;
  final RegisterAuthUsecase regiserAuthUsecase;
  final IsTokenValidAuthUsecase isTokenValidAuthUsecase;
  final GetUserInfoAuthUsecase getUserInfoAuthUsecase;
  final GetUserInfoByIdAuthUsecase getUserInfoByIdAuthUsecase;
  final IsUserOnlineUsecase isUserOnlineUsecase;
  final AddUserFcmTokenUsecase addUserFcmTokenUsecase;

  AuthController({
    required this.loginAuthUsecase,
    required this.regiserAuthUsecase,
    required this.isTokenValidAuthUsecase,
    required this.getUserInfoAuthUsecase,
    required this.getUserInfoByIdAuthUsecase,
    required this.isUserOnlineUsecase,
    required this.addUserFcmTokenUsecase,
  });

  late TextEditingController emailLC;
  late TextEditingController passwordLC;

  late TextEditingController emailRC;
  late TextEditingController passwordRC;
  late TextEditingController nameRC;
  late TextEditingController phoneRC;

  @override
  void onInit() {
    emailLC = TextEditingController();
    passwordLC = TextEditingController();

    emailRC = TextEditingController();
    passwordRC = TextEditingController();
    nameRC = TextEditingController();
    phoneRC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    emailLC.dispose();
    passwordLC.dispose();

    emailRC.dispose();
    passwordRC.dispose();
    nameRC.dispose();
    phoneRC.dispose();
  }

  AuthModel? userData;

  File? photoFile;
  void selectImageFromCamera() async {
    File? image = await pickImageFromCamera();
    if (image != null) {
      photoFile = image;
    }
    AppNavigator.pop();
    update();
  }

  void selectImageFromGallery() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      photoFile = image;
    }
    AppNavigator.pop();
    update();
  }

  void register({
    required String name,
    required String email,
    required String password,
    File? photo,
  }) async {
    showLoading();

    String photoCloud = '';

    if (photo != null) {
      photoCloud = await cloudinaryPublic(photo.path);
    }

    String? fcmToken = await getFirebaseMessagingToken();

    AuthModel auth = AuthModel(
      id: "",
      name: name,
      email: email,
      bio: "",
      friendRequests: [],
      friends: [],
      photo: photoCloud,
      backgroundImage: "",
      phone: "",
      password: password,
      address: "",
      type: "",
      private: false,
      isOnline: false,
      token: "",
      fcmToken: fcmToken ?? "",
    );

    final result = await regiserAuthUsecase(auth);

    result.fold(
      (l) => handleLoading(l),
      (r) {
        emailRC.text = "";
        passwordRC.text = "";
        nameRC.text = "";
        AppNavigator.replaceWith(AppRoutes.login);
        Components.showSnackBar(
          'Signed up successfully login now',
          color: colorPrimary,
          title: 'Signed up',
        );
        hideLoading();
        update();
      },
    );
  }

  void login(
    String email,
    String password,
  ) async {
    showLoading();
    final result = await loginAuthUsecase(email, password);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        userData = r;
        UserLocal().saveUser(r);
        UserLocal().saveUserId(r.id);
        UserLocal().saveAccessToken(r.token);
        AppNavigator.replaceWith(AppRoutes.navigation);
        hideLoading();
        update();
      },
    );
  }

  void getUserInfo() async {
    bool response = false;

    final tokenResult = await isTokenValidAuthUsecase();

    tokenResult.fold(
      (l) => handleLoading(l),
      (r) {
        response = r;
      }
    );

    if (response == true) {
      final result = await getUserInfoAuthUsecase();
      result.fold(
        (l) => handleLoading(l),
        (r) {
          userData = r;
          UserLocal().saveUser(r);
          UserLocal().saveAccessToken(r.token);
          update();
        },
      );
    }
  }

  Future<AuthModel> fetchInfoUserById(String userId) async {
    AuthModel? userData;
    final result = await getUserInfoByIdAuthUsecase(userId);
    result.fold(
      (l) => handleLoading(l),
      (r) => userData = r,
    );
    return userData!;
  }

  Future<void> isUserOnline(bool isOnline) async {
    final result = await isUserOnlineUsecase(isOnline);
    result.fold(
      (l) => handleLoading(l),
      (r) {},
    );
  }

  void isedUserOnline(dynamic data) {}

  Future<void> addUserFcmToken(String fcmToken) async {
    final result = await addUserFcmTokenUsecase(fcmToken);
    result.fold(
      (l) => handleLoading(l),
      (r) {},
    );
  }

  bool onAuthCheck() {
    AuthModel? userLocal = UserLocal().getUser();
    if (userLocal != null) {
      userData = userLocal;
    }
    return UserLocal().getAccessToken() != '';
  }

  void logout() {
    UserLocal().clearUserData();
    UserLocal().clearAccessToken();
    UserLocal().clearUserType();
    AppNavigator.replaceWith(AppRoutes.login);
    update();
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
