import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/features/view/chat/widgets/video_card.dart';
import 'package:social_app/features/view/home/home_widgets/hero_image.dart';

import 'package:social_app/features/view/home/home_widgets/video_out.dart';

class DisplayImageVideoCard extends StatelessWidget {
  final String file;
  final String type;
  final bool isOut;

  const DisplayImageVideoCard({
    Key? key,
    required this.file,
    required this.type,
    required this.isOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == "image"
        ? isOut
            ? SizedBox(
              height: 210,
              child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  imageUrl: file,
                  fit: BoxFit.cover,
                ),
            )
            : InkWell(
                onTap: () {
                  Get.to(HeroImage(post: file));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            file,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
        : isOut
            ? VideoOut(videoUrl: file)
            : VideoCard(videoUrl: file);
  }
}
