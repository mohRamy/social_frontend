import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../home/home_widgets/video_playing.dart';


class ProfileTextImageVideoPost extends StatelessWidget {
  final String post;
  final String type;

  const ProfileTextImageVideoPost({
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
            ?  Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(post))),
                )
              
            : VideoPlayingPost(
                videoUrl: post,
              );
  }
}
