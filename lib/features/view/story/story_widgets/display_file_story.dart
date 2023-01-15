import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/features/view/home/home_widgets/hero_image.dart';
import '../../../../core/enums/story_enum.dart';
import '../../../../core/utils/dimensions.dart';

import '../../post/post_widgets/video_card.dart';

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
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                    message,
                  ),
                ),
              ),
            ),
          )
        : VideoCard(
            videoUrl: message,
          );
  }
}
