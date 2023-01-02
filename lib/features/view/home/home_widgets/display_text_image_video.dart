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
                onTap: () {
                  Get.to(
                    HeroImage(
                      post: post,
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: Dimensions.screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            post,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.2), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                      ),
                    )
                  ],
                ),
              )
            : VideoPlayingPost(
                videoUrl: post,
              );
  }
}
