import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow? overflow;
  int? maxline;
  SmallText({
    Key? key,
    this.maxline,
    this.overflow,
    this.color =const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxline,
      style: TextStyle(
        height: height,
        color: color,
        fontSize: size,
        fontFamily: 'Roboto',
      ),
    );
  }
}
