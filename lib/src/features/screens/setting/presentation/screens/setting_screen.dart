import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/themes/font_family.dart';
import '../../../../../core/widgets/app_text.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../core/widgets/item_setting.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppText('setting'.tr),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          children: [
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'look_for'.tr,
                    hintStyle: TextStyle(
                      fontFamily: FontFamily.lato,
                      color: Colors.grey[400],
                    ),
                    prefixIcon: Icon(Icons.search, color: colorPrimary)),
              ),
            ),
            const SizedBox(height: 15.0),
            ItemSetting(
                text: 'follow_and_invite_friend'.tr,
                icon: Icons.person_add_alt,
                onPressed: () {}),
            ItemSetting(
                text: 'notifications'.tr,
                icon: Icons.notifications_none_rounded,
                onPressed: () {}),
            ItemSetting(
                text: 'privacy'.tr,
                icon: Icons.lock_outline_rounded,
                onPressed: () {
                  AppNavigator.push(AppRoutes.privacy);
                }),
            ItemSetting(
                text: 'security'.tr,
                icon: Icons.security_outlined,
                onPressed: () {
                  AppNavigator.push(AppRoutes.changePassword);
                }),
            ItemSetting(
                text: 'account'.tr,
                icon: Icons.account_circle_outlined,
                onPressed: () {
                  AppNavigator.push(
                    AppRoutes.updateInfo,
                  );
                }),
            ItemSetting(
                text: 'help'.tr,
                icon: Icons.help_outline_rounded,
                onPressed: () {}),
            ItemSetting(
                text: 'about'.tr,
                icon: Icons.info_outline_rounded,
                onPressed: () {}),
            ItemSetting(
              text: 'themes'.tr,
              icon: Icons.palette_outlined,
              onPressed: () {
                AppNavigator.push(AppRoutes.theme);
              },
            ),
            ItemSetting(
              text: 'language'.tr,
              icon: Icons.language,
              onPressed: () {
                AppNavigator.push(AppRoutes.language);
              },
            ),
            const SizedBox(height: 20.0),
            const Row(
              children: [
                Icon(Icons.copyright_outlined),
                SizedBox(width: 5.0),
                AppText('RAMY DEVELOPER'),
              ],
            ),
            const SizedBox(height: 30.0),
            AppText('sessions'.tr),
            const SizedBox(height: 10.0),
            ItemSetting(
                text: 'add_change_account'.tr,
                icon: Icons.add,
                onPressed: () {}),
            ItemSetting(
                text: 'logout'.tr,
                icon: Icons.logout_rounded,
                onPressed: () {
                  if (AppGet.authGet.onAuthCheck()) {
                    AppGet.authGet.logout();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
