import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String videoUrl;
  const VideoItem({
    required this.videoUrl,
    Key? key,
  }) : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late ChewieController _chewieController;
  

  @override
void initState() {
  super.initState();
  _chewieController = ChewieController(
    videoPlayerController: VideoPlayerController.network(widget.videoUrl),
    aspectRatio:5/8,
    autoInitialize: true,
    autoPlay: true,
    looping: true,
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
    return  Chewie(
      controller: _chewieController,
  );
  
}}