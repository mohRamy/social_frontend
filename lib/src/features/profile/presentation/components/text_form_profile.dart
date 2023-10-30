import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../themes/app_colors.dart';


class TextFormProfile extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final bool isReadOnly;
  final int maxLines;

  const TextFormProfile({
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
      style: const TextStyle( 
      //GoogleFonts.getFont('Roboto', 
      fontSize: 18),
      cursorColor: colorBranch,
      keyboardType: keyboardType,
      readOnly: isReadOnly,
      minLines: 1,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Get.isDarkMode ? Colors.white : Colors.black)), 
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorPrimary)), 
        labelText: labelText,
        labelStyle: TextStyle(
          color: context.textTheme.bodyText1!.color,
        ),

      ),
      validator: validator,
    );
  }



}