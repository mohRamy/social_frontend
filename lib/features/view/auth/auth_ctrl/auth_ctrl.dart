import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../controller/user_ctrl.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../../data/api/api_client.dart';
import '../../../../helper/dependencies.dart' as dep;
import '../auth_repo/auth_repo.dart';

class AuthCtrl extends GetxController implements GetxService {
  final ApiClient apiClient;
  final AuthRepo authRepo;
  SharedPreferences sharedPreferences;
  AuthCtrl({
    required this.apiClient,
    required this.authRepo,
    required this.sharedPreferences,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
    try {
      _isLoading = true;
      update();
      http.Response res = await authRepo.signUpUser(
        name: name,
        email: email,
        password: password,
        photo: photo,
      );

      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            title: '',
            'Account created! Login with the same credentials!',
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

  void signInUser(
    String email,
    String password,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await authRepo.login(email, password);

      stateHandle(
        res: res,
        onSuccess: () async {
          await dep.init();
          authRepo.saveUserToken(jsonDecode(res.body)['token']);

          Get.find<UserCtrl>().setUserFromJson(res.body);

          sharedPreferences.setString(
              AppString.TYPE_KEY, jsonDecode(res.body)['type']);

          if (Get.find<UserCtrl>().user.type == 'user') {
            Get.offNamedUntil(Routes.NAV_USER_SCREEN, (route) => false);
          } else {
            Get.offNamedUntil(Routes.SIGN_UP, (route) => false);
          }
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void getUserData() async {
    try {
      _isLoading = true;
      update();
      print(sharedPreferences.getString(AppString.TOKEN));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppString.TOKEN);

      print("oooooooooooo$token ooooooooooooooo");

      if (token == null) {
        prefs.setString(AppString.TOKEN, '');
      }

      http.Response tokenRes = await authRepo.tokenIsValid();
      bool response = jsonDecode(tokenRes.body);

      if (response == true) {
        
        http.Response userRes = await authRepo.getUserData();
        print('iiiiiiiiiiiiiiiiiiiiiioooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');

        print(userRes.body);

        UserCtrl userController = Get.find<UserCtrl>();
        userController.setUserFromJson(userRes.body);
      }
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppString.TOKEN);
    // sharedPreferences.remove(AppString.NUMBER_KEY);
    // sharedPreferences.remove(AppString.PASSWORD_KEY);
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
