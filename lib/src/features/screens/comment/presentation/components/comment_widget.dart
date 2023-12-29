import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import '../../../../../helper/date_time_helper.dart';
import '../controllers/comment_controller.dart';
import '../../../../../resources/local/user_local.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../domain/entities/comment.dart';
import '../../../../taps/home/presentation/controllers/home_controller.dart';

class CommentWidget extends GetView<HomeController> {
  final String itemId;
  final String itemType;
  final Comment commentData;
  final AuthModel userData;
  
  const CommentWidget({
    Key? key,
    required this.itemId,
    required this.itemType,
    required this.commentData,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(builder: (commentCtrl) {
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
                onTap: () {
                  if (commentData.userId != UserLocal().getUserId()) {
                    AppNavigator.push(
                      AppRoutes.anotherProfile,
                      arguments: {
                        "user-id": commentData.userId,
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
                                commentData.createdAt,
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
                                  commentCtrl.changeCommentLike(
                                    itemId,
                                    itemType,
                                    commentData.id,
                                  );
                              },
                              child: Icon(
                                commentCtrl.commentLikes
                                        .contains(commentData.id)
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            commentCtrl.countCommentLikes
                                        .containsKey(commentData.id) &&
                                    commentCtrl.countCommentLikes[
                                            commentData.id] !=
                                        0
                                ? GestureDetector(
                                    onTap: () {
                                      AppNavigator.push(
                                        AppRoutes.like,
                                        arguments: {
                                          "users-id": commentData.likes,
                                        },
                                      );
                                    },
                                    child: TextCustom(
                                      text: commentCtrl
                                          .countCommentLikes[commentData.id]
                                          .toString(),
                                      fontSize: 16,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 260,
                      child: AppText(
                        commentData.comment,
                        type: TextType.medium,
                      ),
                    ),
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
