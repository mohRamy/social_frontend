import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_decorations.dart';
import '../../utils/sizer_custom/sizer.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isObscure;
  const AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.textField(context, 6.sp).decoration,
      child: TextField(
        maxLines: maxLines,
        minLines: 1,
        keyboardType: keyboardType,
        controller: textController,
        obscureText: isObscure ? true : false,
        cursorColor: colorPrimary,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
      );
  }
}
