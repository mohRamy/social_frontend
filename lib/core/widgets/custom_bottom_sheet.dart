import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/core/widgets/widgets.dart';
import '../utils/dimensions.dart';

import '../utils/app_colors.dart';

bottomSheet(
  Function()? pickImageCamera,
  Function()? pickImageGallery,
) {
  return Get.bottomSheet(
    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.height20,
          vertical: Dimensions.height10 + 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose From",
              style: TextStyle(fontSize: Dimensions.font20),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: pickImageCamera,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimensions.height10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 1),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      const Text(
                        'Camera',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Dimensions.width30,
                ),
                GestureDetector(
                  onTap: pickImageGallery,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimensions.height10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 1),
                        ),
                        child: Icon(
                          Icons.photo,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Gallery',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
  );
}
