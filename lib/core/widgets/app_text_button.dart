import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class AppTextButton extends StatelessWidget {
  final String txt;
  final Function() onTap;
  const AppTextButton({
    Key? key,
    required this.txt,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.radius15 - 5,
            ),
          ),
          padding: EdgeInsets.all(Dimensions.height10)),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: Dimensions.font20,
          color: Colors.white,
        ),
      ),
    );
  }
}
