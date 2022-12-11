import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/config/routes/app_pages.dart';
import 'package:social_app/features/auth/auth_screens/signin_screen.dart';

import 'features/auth/auth_repo/auth_repo.dart';


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