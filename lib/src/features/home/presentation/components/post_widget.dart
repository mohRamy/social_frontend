import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';
import 'package:social_app/src/themes/app_colors.dart';
import 'package:social_app/src/themes/font_family.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';

import '../../../../helper/date_time_helper.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(post.userData.photo),
                radius: 20.0,
              ),
              const SizedBox(width: 7.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText(post.userData.name),
                  // Text(post.userData.name,
                  //     style: const TextStyle(
                  //         fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.black)),
                  const SizedBox(height: 5.0),
                  Text(
                    '''${timeAgoCustom(
                      DateTime.fromMillisecondsSinceEpoch(
                        post.time,
                      ),
                    )} . ''',
                    style: TextStyle(
                      color: Get.isDarkMode ? mCL : colorBlack,
                      fontFamily: FontFamily.lato,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          AppText(post.description ?? "", type: TextType.medium),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(FontAwesomeIcons.thumbsUp,
                      size: 15.0, color: Colors.blue),
                  SizedBox(width: 3.sp),
                  Text(
                    '${post.likes.length}',
                    style: TextStyle(
                      color: Get.isDarkMode ? mCL : colorBlack,
                      fontFamily: FontFamily.lato,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    '${post.comments.length} comments  •  ',
                    style: TextStyle(
                      color: Get.isDarkMode ? mCL : colorBlack,
                      fontFamily: FontFamily.lato,
                    ),
                  ),
                  Text(
                    '${post.shares.length} shares',
                    style: TextStyle(
                      color: Get.isDarkMode ? mCL : colorBlack,
                      fontFamily: FontFamily.lato,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 30.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.thumbsUp, size: 20.0),
                  SizedBox(width: 5.0),
                  AppText('Like', type: TextType.medium),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                  SizedBox(width: 5.0),
                  AppText('Comment', type: TextType.medium),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.share, size: 20.0),
                  SizedBox(width: 5.0),
                  AppText('Share', type: TextType.medium),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
