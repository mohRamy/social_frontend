import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../themes/theme_service.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const AppText('Theme'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.size15,
            vertical: Dimensions.size10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Themes',
                type: TextType.medium,
              ),
              Switch(
                value: Get.isDarkMode ? true : false,
                onChanged: (val) {
                  themeService.changeTheme();
                },
                activeColor: colorPrimary,
              ),
              // GetBuilder<ThemeController>(
              //   builder: (themeCtrl) {
              //     return Switch(
              //       value: ThemeService.currentTheme == ThemeMode.dark
              //           ? true
              //           : false,
              //       onChanged: (val) {
              //         themeCtrl.onChangeTheme();
              //       },
              //       activeColor: colorPrimary,
              //     );
              //   }
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// const SizedBox(height: 20.0),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppText('System'),
//                   Icon(Icons.radio_button_off_rounded)
//                 ],
//               ),