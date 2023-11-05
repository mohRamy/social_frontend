import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_clouding.dart';
import 'package:social_app/src/services/firebase_messaging/handle_messaging.dart';
import '../../../../resources/local/user_local.dart';
import '../../../../themes/app_colors.dart';

import '../../../../public/components.dart';
import '../../../../routes/app_pages.dart';
import '../../data/models/auth_model.dart';
import '../../domain/usecases/get_user_info.dart';
import '../../domain/usecases/get_user_info_by_id.dart';
import '../../domain/usecases/is_token_valid.dart';
import '../../domain/usecases/login.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../domain/entities/auth.dart';
import '../../domain/usecases/register.dart';

class AuthController extends GetxController with HandleLoading {
  final LoginAuthUsecase loginAuthUsecase;
  final RegisterAuthUsecase regiserAuthUsecase;
  final IsTokenValidAuthUsecase isTokenValidAuthUsecase;
  final GetUserInfoAuthUsecase getUserInfoAuthUsecase;
  final GetUserInfoByIdAuthUsecase getUserInfoByIdAuthUsecase;

  AuthController({
    required this.loginAuthUsecase,
    required this.regiserAuthUsecase,
    required this.isTokenValidAuthUsecase,
    required this.getUserInfoAuthUsecase,
    required this.getUserInfoByIdAuthUsecase,
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

  AuthModel? userData;

  void register({
    required String name,
    required String email,
    required String password,
    required File? photo,
  }) async {
    String photoCloud = '';
    if (photo != null) {
      photoCloud = await cloudinaryPuplic(photo.path);
    } else {
      photoCloud = "";
    }

    Auth? auth;

    String? token = await getFirebaseMessagingToken();

    print('ppppppppppppppppppppppp');
    print(token);
      
      auth = Auth(
        id: "",
        name: name,
        email: email,
        bio: "",
        followers: const [],
        following: const [],
        photo: photoCloud,
        backgroundImage: "",
        phone: "",
        password: password,
        address: "",
        type: "",
        private: false,
        token: "",
        fcmtoken: token ?? "",
      );

    showLoading();
    final result = await regiserAuthUsecase(auth);

    result.fold(
      (l) => handleLoading(l),
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
      (r) => response = r,
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

  bool onAuthCheck() {
    AuthModel? userLocal = UserLocal().getUser();
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
