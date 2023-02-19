import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/dimensions.dart';
import 'hero_image.dart';

import '../../post/post_widgets/video_card.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final String type;

  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    // final AudioPlayer audioPlayer = AudioPlayer();
    return type == 'text'
        ? Text(
            message,
            style: TextStyle(
              fontSize: Dimensions.font16,
            ),
          )
        : type == 'image'
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChatHeroImage(
                        message: message,
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Hero(
                      tag: 'jj',
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const Text('loading...'),
                        imageUrl: message,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 250,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            // : type == MessageEnum.audio
            //     ? StatefulBuilder(builder: (context, setState) {
            //         return IconButton(
            //           constraints: const BoxConstraints(
            //             minWidth: 100,
            //           ),
            //           onPressed: () async {
            //             if (isPlaying) {
            //               await audioPlayer.pause();
            //               setState(() {
            //                 isPlaying = false;
            //               });
            //             } else {
            //               await audioPlayer.play(UrlSource(message));
            //               setState(
            //                 () {
            //                   isPlaying = true;
            //                 },
            //               );
            //             }
            //           },
            //           icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            //         );
            //       })
            : type == 'gif'
                ? CachedNetworkImage(
                    imageUrl: message,
                  )
                : VideoCard(
                    videoUrl: File(message),
                  );
  }
}
