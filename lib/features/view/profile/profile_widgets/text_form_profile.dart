import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

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
      style: GoogleFonts.getFont('Roboto', fontSize: 18),
      cursorColor: AppColors.bgColor,
      keyboardType: keyboardType,
      readOnly: isReadOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)), 
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)), 
        labelText: labelText,
      ),
      validator: validator,
    );
  }



}