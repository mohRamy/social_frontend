import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/auth/presentation/controller/auth_controller.dart';
import 'features/chat/presentation/controller/chat_controller.dart';
import 'config/themes/theme_services.dart';
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
      Get.find<ChatController>().getMyChat();
    }
    
        return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      themeMode: ModeTheme().theme,
        theme: Themes.light,
        darkTheme: Themes.dark,
      initialRoute: initRoute(),
      unknownRoute: AppPages.routes[2],
      getPages: AppPages.routes,
    );
  }
}