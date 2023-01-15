import 'package:flutter/material.dart';
import 'package:social_app/features/view/story/story_widgets/video_story.dart';

class DisplayImageVideoStory extends StatelessWidget {
  final String message;
  final String type;

  const DisplayImageVideoStory({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == "image"
        ? Stack(
          children: [
            Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.2), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
            Container(
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        message,
                      ),
                    ),
                  ),
                ),
          ],
        )
        : VideoStory(videoUrl: message);
  }
}
