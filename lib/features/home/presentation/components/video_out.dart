import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoOut extends StatefulWidget {
  final String videoUrl;
  const VideoOut({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoOut> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoOut> {
  late VideoPlayerController _videoCtrl;

  @override
  void initState() {
    super.initState();
    _videoCtrl = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then(
        (value) => setState(() {}),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _videoCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          // width: 110,
          child: VideoPlayer(_videoCtrl),
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
    );
  }
}
