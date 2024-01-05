import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app/src/core/enums/type_enum.dart';

import '../../features/screens/add_post/presentation/components/video_card.dart';
import '../../themes/app_decorations.dart';
import '../../utils/sizer_custom/sizer.dart';

class DisplayFileMessage extends StatelessWidget {
  final File file;
  final TypeEnum type;

  const DisplayFileMessage({
    Key? key,
    required this.file,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == TypeEnum.text
        ? Text(
            file.path,
            style: TextStyle(
              fontSize: Dimensions.size16,
            ),
          )
        : type == TypeEnum.image
            ? Container(
                height: 520.sp,
                width: Dimensions.screenWidth * .95,
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: AppDecoration.displayFile(context, file).decoration,
              )
            : type == TypeEnum.video
                ? VideoCardCreatePost(
                    videoUrl: file,
                  )
                : Container();
  }
}
