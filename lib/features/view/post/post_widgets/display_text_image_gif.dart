import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/dimensions.dart';
import 'video_card.dart';

import '../../../../core/enums/message_enum.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final File message;
  final PostEnum type;

  const DisplayTextImageGIF({
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
