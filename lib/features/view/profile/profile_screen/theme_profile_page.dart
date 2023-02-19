import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/themes/theme_services.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/widgets/widgets.dart';


class ThemeProfilePage extends StatelessWidget {

  const ThemeProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Get.isDarkMode? Colors.black: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'change theme', fontWeight: FontWeight.w500 ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: [
              
              InkWell(
                onTap: () {
                  ModeTheme().changeTheme();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon(CupertinoIcons.sun_dust),
                    const TextCustom(text: 'Day'),
                    Icon(Icons.radio_button_checked, color: AppColors.primary)
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextCustom(text: 'Evening'),
                  Icon(Icons.radio_button_off_rounded )
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextCustom(text: 'System'),
                  Icon(Icons.radio_button_off_rounded )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}