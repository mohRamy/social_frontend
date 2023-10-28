import 'package:flutter/material.dart';
import 'package:social_app/src/themes/app_colors.dart';

import '../../utils/sizer_custom/sizer.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.size24,
        width: Dimensions.size24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.sp),
          color: colorPrimary,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}