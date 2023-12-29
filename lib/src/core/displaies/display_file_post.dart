import 'dart:io';

import 'package:flutter/material.dart';

import '../../features/screens/add_post/presentation/components/video_card.dart';
import '../../themes/app_decorations.dart';
import '../../utils/sizer_custom/sizer.dart';
import '../enums/post_enum.dart';

class DisplayFilePost extends StatelessWidget {
  final File file;
  final PostEnum type;

  const DisplayFilePost({
    Key? key,
    required this.file,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == PostEnum.text
        ? Text(
            file.path,
            style: TextStyle(
              fontSize: Dimensions.size16,
            ),
          )
        : type == PostEnum.image
            ? Container(
                height: 150.sp,
                width: Dimensions.screenWidth * .95,
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration:
                    AppDecoration.displayFile(context, file).decoration,
              )
            : type == PostEnum.video
                ? VideoCardCreatePost(
                    videoUrl: file,
                  )
                : Container();
  }
}
