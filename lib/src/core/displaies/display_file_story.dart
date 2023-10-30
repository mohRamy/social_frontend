import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/post/presentation/components/video_card.dart';
import '../../themes/app_decorations.dart';
import '../../utils/sizer_custom/sizer.dart';
import '../enums/story_enum.dart';
import '../widgets/hero_image.dart';

class DisplayFileStory extends StatelessWidget {
  final File message;
  final StoryEnum type;

  const DisplayFileStory({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == StoryEnum.image
        ? InkWell(
            onTap: () {
              Get.to(HeroImage(post: message.path));
            },
            child: Container(
              height: 150,
              width: Dimensions.screenWidth * .95,
              margin: const EdgeInsets.only(bottom: 10.0),
              decoration: AppDecoration.displayFile(context, message).decoration,
            ),
          )
        : VideoCard(
            videoUrl: message,
          );
  }
}
