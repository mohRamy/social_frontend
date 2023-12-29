import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';

class TextFormSetting extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final bool isReadOnly;
  final int maxLines;

  const TextFormSetting({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isReadOnly = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.titleLarge,
      cursorColor: colorBranch,
      keyboardType: keyboardType,
      readOnly: isReadOnly,
      minLines: 1,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Get.isDarkMode ? mCL : colorBlack,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colorPrimary,
          ),
        ),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      validator: validator,
    );
  }
}
