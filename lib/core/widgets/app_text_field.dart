import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final int maxLines;
  bool isObscure;
  AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.suffixIcon = const SizedBox(),
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        minLines: 1,
        keyboardType: keyboardType,
        controller: textController,
        obscureText: isObscure ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.canvas,
          ),
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
