import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/sizer_custom/sizer.dart';

import '../../../../themes/app_colors.dart';

class CustomShimmerLike extends StatelessWidget {
  const CustomShimmerLike({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Get.isDarkMode ? fCD : mCM,
            highlightColor: Get.isDarkMode ? mCH : mC,
            direction: ShimmerDirection.ltr,
            child: Row(
              children: [
                    CircleAvatar(
                      radius: 25.sp,
                      backgroundColor: Get.isDarkMode ? fCL : mCL,
                    ),
                    SizedBox(width: 10.sp),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Container(
                              height: 10.sp,
                              width: 130.sp,
                              margin: EdgeInsets.only(
                                right: 5.sp,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  2.sp,
                                ),
                                color: Get.isDarkMode ? fCL : mCL,
                              ),
                            ),
                            SizedBox(height: 5.sp),
                            Container(
                              height: 10.sp,
                              width: 170.sp,
                              margin: EdgeInsets.only(
                                right: 5.sp,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  2.sp,
                                ),
                                color: Get.isDarkMode ? fCL : mCL,
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
          ),
        );
      },
    );
  }
}
