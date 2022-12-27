import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'video_playing.dart';
import '../../../../core/utils/dimensions.dart';

import 'hero_image.dart';

class DisplayTextImageVideoPost extends StatelessWidget {
  final String post;
  final String type;

  const DisplayTextImageVideoPost({
    Key? key,
    required this.post,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == "text"
        ? Text(
            post,
            style: TextStyle(
              fontSize: Dimensions.font16,
            ),
          )
        : type == "image"
            ? InkWell(
              onTap: (){
                Get.to(HeroImage(
                        post: post,
                      ),);
              },
              child: Container(
                  // height: 150,
                  width: Dimensions.screenWidth,
                  // margin: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        post,
                      ),
                    ),
                  ),
                ),
            )
            : VideoPlayingPost(
                videoUrl: post,
              );
  }
}
