import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/hero_image.dart';
import '../enums/story_enum.dart';
import '../utils/dimensions.dart';

import '../../features/post/presentation/components/video_card.dart';

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
