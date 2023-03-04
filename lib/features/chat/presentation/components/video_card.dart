import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../home/presentation/components/video_item.dart';



class VideoCard extends StatefulWidget {
  final String videoUrl;
  const VideoCard({ 
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController videoPlayerC;

  @override
  void initState() {
    super.initState();
    videoPlayerC =
        VideoPlayerController.network(widget.videoUrl)..initialize();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: (){
            Get.to(VideoItem(videoUrl: widget.videoUrl));
          },
          child: Stack(
          children: [
            VideoPlayer(videoPlayerC),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.2),
                radius: Dimensions.radius30 - 3,
                child: Icon(
                  Icons.play_arrow,
                  size: Dimensions.iconSize24 + 11,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
