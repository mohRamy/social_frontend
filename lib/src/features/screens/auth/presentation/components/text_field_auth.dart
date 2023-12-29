import 'package:flutter/material.dart';

import '../../../../../utils/sizer_custom/sizer.dart';



class TextFieldAuthCustom extends StatelessWidget {
  final String label;
  final bool isPass;
  final TextEditingController controller;
  final Widget suffixIcon;
  final TextInputType keyboardType;

  const TextFieldAuthCustom({
    Key? key,
    required this.label,
    required this.isPass,
    required this.controller,
    this.suffixIcon = const SizedBox(),
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: Dimensions.screenWidth * 0.9,
        child: TextField(
          controller: controller,
          obscureText: isPass,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: Dimensions.size15,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[700]!,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}