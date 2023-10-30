import 'dart:io';

import 'package:flutter/material.dart';
import '../../themes/app_decorations.dart';

import '../../features/post/presentation/components/video_card.dart';
import '../../utils/sizer_custom/sizer.dart';
import '../enums/post_enum.dart';

class DisplayFilePost extends StatelessWidget {
  final File message;
  final PostEnum type;

  const DisplayFilePost({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == PostEnum.text
        ? Text(
            message.path,
            style: TextStyle(
              fontSize: Dimensions.size16,
            ),
          )
        : type == PostEnum.image
            ? 
                Container(
                    height: 150.sp,
                    width: Dimensions.screenWidth * .95,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: AppDecoration.displayFile(context, message).decoration,
              )
            : VideoCard(
                videoUrl: message,
              );
  }
}
