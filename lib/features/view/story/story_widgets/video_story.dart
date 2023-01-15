// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

// class VideoStory extends StatefulWidget {
//   final String videoUrl;
//   const VideoStory({
//     Key? key,
//     required this.videoUrl,
//   }) : super(key: key);

//   @override
//   State<VideoStory> createState() => _VideoStoryState();
// }

// class _VideoStoryState extends State<VideoStory> {
//   String? thumbnailUrl;
//   videoTh () async {
//     thumbnailUrl = await VideoThumbnail.thumbnailFile(video: widget.videoUrl);
//   }

//   @override
//   void initState() {
//     super.initState();
//     videoTh();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: 110,
//           child: Image.file(File(thumbnailUrl!)),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.black.withOpacity(0.2), Colors.transparent],
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoStory extends StatefulWidget {
  final String videoUrl;
  const VideoStory({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoStory> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoStory> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoCtrl;

  @override
  void initState() {
    super.initState();
    _videoCtrl = VideoPlayerController.network(widget.videoUrl)..initialize().then((value) => setState(() {}));
    // _chewieController = ChewieController(
    //   videoPlayerController: VideoPlayerController.network(widget.videoUrl),
    //   aspectRatio: 0.9,
    //   showOptions: false,
    //   showControls: false,
    //   looping: true,
    //   autoPlay: false,
    //   autoInitialize: true,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SizedBox(
            width: 110,
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
