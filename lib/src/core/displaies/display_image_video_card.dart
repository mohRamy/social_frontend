import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/taps/home/presentation/components/video_out.dart';
import '../../themes/app_decorations.dart';
import '../widgets/expandable_text_widget.dart';
import '../widgets/hero_image.dart';
import '../widgets/video_card_network.dart';

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
    return type == 'text'
        ? ExpandableTextWidget(text: file)
    : type == "image"
        ? isOut
            ? SizedBox(
                height: 210,
                width: 110,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    decoration:
                        AppDecoration.displayImageVideo(context).decoration,
                  ),
                  imageUrl: file,
                  fit: BoxFit.cover,
                ),
              )
            : InkWell(
                onTap: () {
                  Get.to(HeroImage(image: file));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration:
                          AppDecoration.displayImageVideo(context).decoration,
                    ),
                    Container(
                      height: 300,
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
            : VideoCardNetwork(videoUrl: file);
  }
}
