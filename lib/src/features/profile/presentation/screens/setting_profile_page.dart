import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/app_controller.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../resources/local/user_local.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../components/item_profile.dart';
import 'change_password_page.dart';
import 'privacy_profile_page.dart';
import 'theme_profile_page.dart';

class SettingProfileScreen extends StatelessWidget {
  const SettingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TextCustom(
            text: 'Setting', fontSize: 19, fontWeight: FontWeight.w500),
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
                    hintText: 'Look for',
                    hintStyle: TextStyle(
                      // GoogleFonts.getFont('Roboto',
                      color: Colors.grey[400],
                    ),
                    prefixIcon: Icon(Icons.search, color: colorPrimary)),
              ),
            ),
            const SizedBox(height: 15.0),
            ItemProfile(
                text: 'Follow and invite a friend',
                icon: Icons.person_add_alt,
                onPressed: () {}),
            ItemProfile(
                text: 'notifications',
                icon: Icons.notifications_none_rounded,
                onPressed: () {}),
            ItemProfile(
              text: 'Privacy',
              icon: Icons.lock_outline_rounded,
              onPressed: () {
                Get.to(const PrivacyProfilePage());
              },
            ),
            ItemProfile(
              text: 'Security',
              icon: Icons.security_outlined,
              onPressed: () {
                Get.to(const ChangePasswordPage());
              },
            ),
            ItemProfile(
              text: 'Account',
              icon: Icons.account_circle_outlined,
              onPressed: () {
                AppNavigator.push(
                  AppRoutes.accountProfile,
                  arguments: UserLocal().getUser()!,
                );
              },
            ),
            ItemProfile(
                text: 'Help',
                icon: Icons.help_outline_rounded,
                onPressed: () {}),
            ItemProfile(
                text: 'About',
                icon: Icons.info_outline_rounded,
                onPressed: () {}),
            ItemProfile(
              text: 'Themes',
              icon: Icons.palette_outlined,
              onPressed: () {
                Get.to(const ThemeProfilePage());
              },
            ),
            const SizedBox(height: 20.0),
            const Row(
              children: [
                Icon(Icons.copyright_outlined),
                SizedBox(width: 5.0),
                TextCustom(
                    text: 'RAMY DEVELOPER',
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ],
            ),
            const SizedBox(height: 30.0),
            const TextCustom(
                text: 'Sessions', fontSize: 17, fontWeight: FontWeight.w500),
            const SizedBox(height: 10.0),
            ItemProfile(
                text: 'Add or change account',
                icon: Icons.add,
                // colorText: AppColors.primary,
                onPressed: () {}),
            ItemProfile(
                text: 'Sign out',
                icon: Icons.logout_rounded,
                // colorText: AppColors.primary,
                onPressed: () {
                  if (AppGet.authGet.onAuthCheck()) {
                    Get.offNamed(AppRoutes.login);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
