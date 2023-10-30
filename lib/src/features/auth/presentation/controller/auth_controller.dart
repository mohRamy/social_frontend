import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';

import '../../../../models/user_model.dart';
import '../../../../public/components.dart';
import '../../../../resources/local/user_local.dart';
import '../../../../routes/app_pages.dart';
import '../../domain/usecases/get_user_info.dart';
import '../../domain/usecases/get_user_info_by_id.dart';
import '../../domain/usecases/is_token_valid.dart';
import '../../domain/usecases/sign_in.dart';

import '../../../../core/error/handle_error_loading.dart';
// import '../../../../helper/dependencies.dart' as dep;
import '../../domain/entities/auth.dart';
import '../../domain/usecases/sign_up.dart';

class AuthController extends GetxController with HandleErrorLoading {
  final SignInAuthUsecase signInAuthUsecase;
  final SignUpAuthUsecase signUpAuthUsecase;
  final IsTokenValidAuthUsecase isTokenValidAuthUsecase;
  final GetUserInfoAuthUsecase getUserInfoAuthUsecase;
  final GetUserInfoByIdAuthUsecase getUserInfoByIdAuthUsecase;
  // final ApiClient apiClient;
  // GetStorage box;

  AuthController({
    required this.signInAuthUsecase,
    required this.signUpAuthUsecase,
    required this.isTokenValidAuthUsecase,
    required this.getUserInfoAuthUsecase,
    required this.getUserInfoByIdAuthUsecase,
    // required this.apiClient,
    // required this.box,
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

  UserModel? userModel;
  Auth? userData;

  void register({
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

    //   await FirebaseMessaging.instance.getToken().then((value){
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
      fcmtoken: "",
    );
    // });

    showLoading();
    final result = await signUpAuthUsecase(auth);

    result.fold(
      (l) => handleError(l),
      (r) {
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
    final result = await signInAuthUsecase(email, password);
    result.fold(
      (l) => handleError(l),
      (r) {
        userData = r;
        UserLocal().saveUserId(r.id);
        UserLocal().saveAccessToken(r.token);
        UserLocal().saveUserType(r.type);
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
      (l) => handleError(l),
      (r) => response = r,
    );

    if (response == true) {
      final result = await getUserInfoAuthUsecase();
      result.fold(
        (l) => handleError(l),
        (r) {
          userData = r;
          UserLocal().saveUser(r);
          update();
        },
      );
    }
  }
  
  Future<Auth> fetchInfoUserById(String userId) async {
    Auth? userData;
    final result = await getUserInfoByIdAuthUsecase(userId);
    result.fold(
      (l) => handleError(l),
      (r) => userData = r,
    );
    return userData!;
  }

  // save user token
  // void saveUserToken(String token) {
  //   apiClient.token = token;
  //   apiClient.updateHeaders(token);
  //   box.write(AppString.token, token);
  // }

  // String getUserToken() {
  //   return box.read(AppString.token) ?? '';
  // }

  // String getUserType() {
  //   return box.read(AppString.typeKey) ?? '';
  // }

  // bool userLoggedIn() {
  //   return box.hasData(AppString.token);
  // }

  // bool clearSharedData() {
  //   box.remove(AppString.token);
  //   apiClient.token = '';
  //   apiClient.updateHeaders('');
  //   return true;
  // }

  bool onAuthCheck() {
    Auth? userLocal = UserLocal().getUser();
    if (userLocal != null) {
      userData = userLocal;
    }
    return UserLocal().getAccessToken() != '';
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
