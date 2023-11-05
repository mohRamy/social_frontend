import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/src/controller/app_controller.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/sizer_custom/sizer.dart';

import '../../../../core/widgets/expandable_text_widget.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/comment.dart';
import '../controller/home_controller.dart';

class CommentWidget extends GetView<HomeController> {
  final String type;
  final Comment commentData;
  final AuthModel userData;
  final String uid;
  const CommentWidget({
    Key? key,
    required this.type,
    required this.commentData,
    required this.userData,
    required this.uid,
  }) : super(key: key);

  String timeAgoCustom(DateTime date) {
    Duration diff = DateTime.now().difference(date);
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
      return DateFormat.E().add_jm().format(date);
    }
    if (diff.inHours > 0) {
      return "Today ${DateFormat('jm').format(date)}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeCtrl) {
      return Padding(
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
              GestureDetector(
                onTap: (){
                  if (commentData.userId != AppGet.authGet.userData?.id) {
          AppNavigator.push(
            AppRoutes.profileById,
            arguments: {
              "userId": commentData.userId,
            },
          );
        } else {
          AppNavigator.push(
            AppRoutes.profile,
          );
        }
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                    userData.photo,
                  ),
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
                              text: userData.name,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(width: Dimensions.size15),
                            TextCustom(
                              text: timeAgoCustom(
                                DateTime.fromMillisecondsSinceEpoch(
                                  commentData.time,
                                ),
                              ),
                              fontSize: 13,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (homeCtrl.likesCommentPost
                                    .contains(commentData.id)) {
                                  homeCtrl
                                      .removeCommentlike(commentData.id);
                                  homeCtrl.addLikeCommentPost(
                                    uid,
                                    commentData.id,
                                  );
                                } else {
                                  homeCtrl.setCommentLike(commentData.id);
                                  homeCtrl.addLikeCommentPost(
                                    uid,
                                    commentData.id,
                                  );
                                }
                              },
                              child: Icon(
                                homeCtrl.likesCommentPost
                                        .contains(commentData.id)
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            homeCtrl.countLikeCommentPost.containsKey(commentData.id) &&
                                    homeCtrl.countLikeCommentPost[commentData.id] != 0
                                ? GestureDetector(
                                    onTap: () {
                                      AppNavigator.push(
                                        AppRoutes.likes,
                                        arguments: {
                                          "usersId": commentData.likes,
                                        },
                                      );
                                    },
                                    child: TextCustom(
                                      text: homeCtrl.countLikeCommentPost[
                                              commentData.id]
                                          .toString(),
                                      fontSize: 16,
                                    ),
                                  )
                                : Container(),
                            // GestureDetector(
                            //   onTap: () {
                            //     AppNavigator.push(
                            //       AppRoutes.likes,
                            //       arguments: {
                            //         "usersId": commentData.likes,
                            //       },
                            //     );
                            //   },
                            //   child: TextCustom(
                            //     text: commentData.likes.isEmpty
                            //         ? "Like"
                            //         : commentData.likes.length.toString(),
                            //     fontSize: 16,
                            //   ),
                            // ),
                          ],
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       isLike = !isLike;
                        //     });
                        //     if (type == "post") {
                        //       homeCtrl.postCommentLike(
                        //         uid,
                        //         commentData.id,
                        //       );
                        //     } else {
                        //       homeCtrl.storyCommentLike(
                        //         uid,
                        //         commentData.id,
                        //       );
                        //     }
                        //   },
                        //   borderRadius: BorderRadius.circular(50),
                        //   child: Icon(
                        //     (meLike || isLike)
                        //         ? Icons.favorite_outlined
                        //         : Icons.favorite_border_outlined,
                        //     color: (meLike || isLike)
                        //         ? Colors.red
                        //         : Colors.black,
                        //   ),
                        // ),
                        // SizedBox(width: Dimensions.size10),
                        // commentData.likes.isNotEmpty
                        //     ? InkWell(
                        //         onTap: () async {
                        //           List<Auth> userLikes = [];
                        //           for (var i = 0;
                        //               i < commentData.likes.length;
                        //               i++) {
                        //             userLikes.add(await AppGet.authGet
                        //                 .fetchInfoUserById(
                        //                     commentData.likes[i]));
                        //           }
                        //           AppNavigator.push(
                        //             AppRoutes.likes,
                        //             arguments: userLikes,
                        //           );
                        //         },
                        //         child: TextCustom(
                        //           text: commentData.likes.length
                        //               .toString(),
                        //           fontSize: 16,
                        //           color: Colors.black,
                        //         ),
                        //       )
                        //     : Container(),
                      ],
                    ),
                    SizedBox(height: Dimensions.size5),
                    SizedBox(
                      width: 260,
                      child: ExpandableTextWidget(
                        text: commentData.comment,
                      ),
                    ),
                    // add dots to show this is a longer text
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
