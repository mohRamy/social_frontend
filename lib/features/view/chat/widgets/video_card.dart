import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/utils/dimensions.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../core/utils/components/components.dart';

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
  late CachedVideoPlayerController videoPlayerController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        CachedVideoPlayerController.network(widget.videoUrl);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Components.navigateTo(context, Routes.videoItem, widget.videoUrl);
        },
        child: Stack(
          children: [
            CachedVideoPlayer(videoPlayerController),
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
