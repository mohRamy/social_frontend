import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayingPost extends StatefulWidget {
  final String videoUrl;
  const VideoPlayingPost({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayingPost> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoPlayingPost> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(widget.videoUrl),
      aspectRatio: 2,
      showOptions: false,
      showControlsOnInitialize: false,
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
    // Container(
    //   height: 150,
    //   width: Dimensions.screenWidth * .95,
    //   margin: const EdgeInsets.only(bottom: 10.0),
    //   decoration: BoxDecoration(
    //     color: Colors.blue,
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(10.0),
    //     child: Chewie(
    //       controller: _chewieController,
    //     ),
    //   ),
    // );
  }
}
