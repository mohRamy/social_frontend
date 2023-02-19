import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/features/auth/domain/entities/auth.dart';
import 'package:social_app/features/auth/presentation/controller/auth_controller.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../controller/user_ctrl.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/expandable_text_widget.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/models/user_model.dart';
import '../../auth/auth_ctrl/auth_ctrl.dart';
import '../home_ctrl/home_ctrl.dart';

class CommentWidget extends StatefulWidget {
  final String type;
  final CommentMode commentData;
  final Auth userData;
  final String uid;
  const CommentWidget({
    Key? key,
    required this.type,
    required this.commentData,
    required this.userData,
    required this.uid,
  }) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool isLike = false;

  String timeAgoCustom(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return DateFormat.E().add_jm().format(d);
    }
    if (diff.inHours > 0) {
      return "Today ${DateFormat('jm').format(d)}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      bool meLike =
          widget.commentData.likes.contains(Get.find<UserCtrl>().user.id);
      return InkWell(
        onTap: () {
          if (widget.commentData.userId != Get.find<UserCtrl>().user.id) {
            Get.toNamed(
              Routes.PROFILE,
              arguments: widget.commentData.userId,
            );
          } else {
            Get.toNamed(
              Routes.PROFILE,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: const EdgeInsets.only(
              top: 5.0,
              right: 5.0,
              bottom: 5.0,
            ),
            // color: Colors.green,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                    widget.userData.photo,
                  ),
                ),
                const SizedBox(width: 10.0),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              TextCustom(
                                text: widget.userData.name,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: Dimensions.width15),
                              TextCustom(
                                text: timeAgoCustom(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    widget.commentData.time,
                                  ),
                                ),
                                fontSize: 13,
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isLike = !isLike;
                                });
                                if (widget.type == "post") {
                                  homeCtrl.postCommentLike(
                                    widget.uid,
                                    widget.commentData.id,
                                  );
                                } else {
                                  homeCtrl.storyCommentLike(
                                    widget.uid,
                                    widget.commentData.id,
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Icon(
                                (meLike || isLike)
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_border_outlined,
                                color: (meLike || isLike)
                                    ? Colors.red
                                    : Colors.black,
                              )),
                          SizedBox(width: Dimensions.width10),
                          widget.commentData.likes.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    List<Auth> userLikes = [];
                                    for (var i = 0;
                                        i < widget.commentData.likes.length;
                                        i++) {
                                      userLikes.add(await Get.find<AuthController>()
                                          .getUserData(
                                              widget.commentData.likes[i]));
                                    }
                                    Get.toNamed(
                                      Routes.LIKES,
                                      arguments: userLikes,
                                    );
                                  },
                                  child: TextCustom(
                                    text: widget.commentData.likes.length
                                        .toString(),
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10 - 2),

                      SizedBox(
                        width: 260,
                        child: ExpandableTextWidget(
                          text: widget.commentData.comment,
                        ),
                      ),
                      // add dots to show this is a longer text
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
