import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/widgets/app_text.dart';
import '../core/widgets/widgets.dart';
import '../themes/app_colors.dart';
import '../utils/sizer_custom/sizer.dart';


class Components {
    static void showLoading([String? message]) {
    Get.dialog(
      const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  static InkWell buildbottomsheet({
    required Icon icon,
    required String label,
    required Function() ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.size10),
        height: Dimensions.size45,
        color: Get.isDarkMode ? colorBlack : mC,
        child: Row(
          children: [
            icon,
            SizedBox(width: Dimensions.size10),
            TextCustom(text: label),
          ],
        ),
      ),
    );
  }

  static void showSnackBar(
    String message, {
    String title = 'Error',
    Color color = Colors.redAccent,
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: AppText(
        title,
      ),
      messageText: AppText(
        message,
      ),
      colorText: mCL,
      snackPosition: snackPosition,
      backgroundColor: color,
    );
  }
}
