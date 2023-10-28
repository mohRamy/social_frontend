import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';

class ItemProfile extends StatelessWidget {
  final double height;
  final String text;
  final IconData icon;
  final Function() onPressed;

  const ItemProfile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.height = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10.0),
            TextCustom(text: text, fontSize: 17)
          ],
        ),
      ),
    );
  }
}