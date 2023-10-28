import 'package:flutter/material.dart';

enum TextType {
  large,
  medium,
  small,
}

class AppText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextOverflow overflow;
  final Color color;
  final double height;
  final TextType type;
  const AppText(
    this.text, {
    Key? key,
    this.type = TextType.large,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.color = Colors.grey,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: type == TextType.large
          ? Theme.of(context).textTheme.titleLarge
          : type == TextType.medium
              ? Theme.of(context).textTheme.titleMedium
              : Theme.of(context).textTheme.bodyLarge,
    );
  }
}
