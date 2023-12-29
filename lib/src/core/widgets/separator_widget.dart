import 'package:flutter/material.dart';

import '../../utils/sizer_custom/sizer.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: MediaQuery.of(context).size.width,
      height: 5.sp,
    );
  }
}