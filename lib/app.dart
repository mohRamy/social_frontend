import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/config/themes/theme_services.dart';
import 'package:social_app/controller/user_ctrl.dart';
import 'package:social_app/core/utils/constants/global_variables.dart';
import 'package:social_app/features/view/chat/controller/chat_ctrl.dart';
import 'package:social_app/features/view/profile/profile_screen/account_profile_page.dart';
import 'package:social_app/features/view/profile/profile_screen/privacy_profile_page.dart';
import 'package:social_app/features/view/profile/profile_screen/saved_posts_page.dart';
import 'package:social_app/features/view/profile/profile_screen/setting_profile_page.dart';
import 'config/routes/app_pages.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'features/view/auth/auth_ctrl/auth_ctrl.dart';
import 'features/view/auth/auth_repo/auth_repo.dart';



class SocialApp extends StatelessWidget {
  const SocialApp({
    Key? key,
  }) : super(key: key);

  String initRoute() {
      if (Get.find<AuthRepo>().userLoggedIn()) {
        return Routes.NAV_USER_SCREEN;
      } else {
        return Routes.SIGN_IN;
      }
  }
  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthRepo>().userLoggedIn()) {
      Get.find<AuthCtrl>().fetchMyData();
      Get.find<ChatCtrl>().fetchAllChatContact();
    }
    
        return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.APP_NAME,
      themeMode: ModeTheme().theme,
        theme: Themes.light,
        darkTheme: Themes.dark,
      // theme: ThemeData(
      //   primaryColor: AppColors.primary,
      //   appBarTheme: AppBarTheme(
      //     elevation: 0,
      //     backgroundColor: AppColors.bgBlackColor,
      //     iconTheme: const IconThemeData(
      //       color: Colors.black,
      //     ),
      //   ),

      //   useMaterial3: true, 
      // ),
      initialRoute: initRoute(),
      unknownRoute: AppPages.routes[2],
      getPages: AppPages.routes,
    );
  }
}