import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/core/network/network_info.dart';
import 'config/routes/app_pages.dart';
import 'controller/user_ctrl.dart';
import 'features/view/auth/auth_ctrl/auth_ctrl.dart';
import 'features/view/auth/auth_repo/auth_repo.dart';



class MyApp extends StatelessWidget {
  MyApp({super.key});

  AuthRepo authRepo = Get.find<AuthRepo>();

  String initRoute() {
      if (authRepo.userLoggedIn()) {
        return Routes.NAV_USER_SCREEN;
      } else {
        return Routes.SIGN_IN;
      }
  }
  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthRepo>().userLoggedIn()) {
      Get.find<AuthCtrl>().fetchMyData();
    }
    
    print(Get.find<UserCtrl>().user.email);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initRoute(),
      getPages: AppPages.routes,
    );
  }
}