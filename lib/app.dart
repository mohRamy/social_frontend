import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/user_ctrl.dart';
import 'package:social_app/features/auth/presentation/controller/auth_controller.dart';
import 'package:social_app/features/view/auth/auth_ctrl/auth_ctrl.dart';
import 'config/themes/theme_services.dart';
import 'features/view/chat/controller/chat_ctrl.dart';
import 'config/routes/app_pages.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';



class SocialApp extends StatelessWidget {
  const SocialApp({
    Key? key,
  }) : super(key: key);

  String initRoute() {
      if (Get.find<AuthController>().userLoggedIn()) {
        return Routes.NAV_USER_SCREEN;
      } else {
        return Routes.SIGN_IN;
      }
  }
  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthController>().userLoggedIn()) {
      Get.find<AuthController>().getMyData();
      Get.find<ChatCtrl>().fetchAllChatContact();
    }
    
        return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.APP_NAME,
      themeMode: ModeTheme().theme,
        theme: Themes.light,
        darkTheme: Themes.dark,
      initialRoute: initRoute(),
      unknownRoute: AppPages.routes[2],
      getPages: AppPages.routes,
    );
  }
}