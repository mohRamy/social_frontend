import 'dart:io';

import 'package:flutter/material.dart';

import '../../features/post/presentation/components/video_card.dart';
import '../enums/post_enum.dart';
import '../utils/dimensions.dart';

class DisplayFilePost extends StatelessWidget {
  final File message;
  final PostEnum type;

  const DisplayFilePost({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == PostEnum.text
        ? Text(
            message.path,
            style: TextStyle(
              fontSize: Dimensions.font16,
            ),
          )
        : type == PostEnum.image
            ? 
                Container(
                    height: 150,
                    width: Dimensions.screenWidth * .95,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          message,
                        ),
                      ),
                    ),
                  
                  
                
              )
            : VideoCard(
                videoUrl: message,
              );
  }
}
