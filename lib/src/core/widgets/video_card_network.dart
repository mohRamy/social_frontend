import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/sizer_custom/sizer.dart';
import 'package:video_player/video_player.dart';

import 'video_item.dart';


class VideoCardNetwork extends StatefulWidget {
  final String videoUrl;
  const VideoCardNetwork({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoCardNetwork> createState() => _VideoCardNetworkState();
}

class _VideoCardNetworkState extends State<VideoCardNetwork> {
  late VideoPlayerController videoPlayerC;

  @override
  void initState() {
    super.initState();
    videoPlayerC =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))..initialize();
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
                radius: 33.sp,
                child: Icon(
                  Icons.play_arrow,
                  size: 35.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
