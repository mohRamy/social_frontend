import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/widgets/app_text.dart';
import '../themes/app_colors.dart';


class Components {
  // static void showBottomSheetPost(
  //   {
  //     required Post postData,

  //   }
  // ) {
  //   Get.bottomSheet(
  //     SingleChildScrollView(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(Dimensions.size15),
  //           color: Get.isDarkMode ? Colors.black : Colors.white,
  //         ),
  //         padding: const EdgeInsetsDirectional.only(
  //           top: 4,
  //         ),
  //         width: Dimensions.screenWidth,
  //         height: Dimensions.size10 * 15,
  //         child: Column(
  //           children: [
  //             Flexible(
  //               child: Container(
  //                 height: 6,
  //                 width: 120,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             AppComponents.buildbottomsheet(
  //               icon: Icon(
  //                 Icons.edit,
  //                 color: AppColors.origin,
  //               ),
  //               label: "Modify post",
  //               ontap: () {
  //                 Get.to(
  //                   () => const ModifyPostScreen(),
  //                   arguments: postData,
  //                 );
  //               },
  //             ),
  //             Divider(
  //               color: Get.isDarkMode ? Colors.white : Colors.black,
  //             ),
  //             AppComponents.buildbottomsheet(
  //               icon: const Icon(
  //                 Icons.delete,
  //                 color: Colors.red,
  //               ),
  //               label: "Delete post",
  //               ontap: () {
  //                 AppComponents.showDialog(
  //                   title: "delete Post",
  //                   description: "Are you sure to delete this post ?",
  //                   onPressed: () {
  //                     homeCtrl.deletePost(postData.id);
  //                     AppNavigator.pop;
  //                     AppNavigator.pop;
  //                   },
  //                   color: Colors.red,
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     elevation: 0.4,
  //   );
  // }

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
