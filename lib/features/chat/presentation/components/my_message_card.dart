import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../auth/presentation/controller/user_controller.dart';
import '../../domain/entities/chat.dart';
import 'display_text_image_gif.dart';

class MyMessageCard extends StatelessWidget {
  final Msg msg;
  final String date;
  final VoidCallback onLeftSwipe;
  final RepliedMsg repliedMsg;
  final bool isSeen;

  const MyMessageCard({
    Key? key,
    required this.msg,
    required this.date,
    required this.onLeftSwipe,
    required this.repliedMsg,
    required this.isSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message = msg.message;
    String type = msg.type;
    String repliedMessage = repliedMsg.repliedMessage;
    String repliedType = repliedMsg.type;
    bool isReplying = repliedMsg.repliedMessage.isNotEmpty;
    String typeIcon() {
      String contactMsg;
      switch (repliedMsg.type) {
        case 'image':
          contactMsg = '📷 Photo';
          break;
        case 'video':
          contactMsg = '📸 Video';
          break;
        case 'audio':
          contactMsg = '🎵 Audio';
          break;
        case 'gif':
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      return contactMsg;
    }

    return SwipeTo(
      onRightSwipe: onLeftSwipe,
      child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: type == "text" ? 130 : 200,
              maxWidth: 270,
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: AppColors.chatBoxMe,
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.height15,
                  vertical: Dimensions.height10 - 5),
              child: type == "text" || type == "audio"
                  ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.height10 - 5,
                            right: Dimensions.height10 - 5,
                            top: Dimensions.height10,
                            bottom: Dimensions.height20,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: Dimensions.height10 - 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isReplying
                                    ? repliedType == "text" ||
                                            repliedType == "audio"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(
                                                    Dimensions.height10 - 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.bgLightColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      repliedMsg.repliedTo ==
                                                              Get.find<
                                                                      UserController>()
                                                                  .user
                                                                  .name
                                                          ? repliedMsg
                                                              .repliedTo
                                                          : 'You',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: repliedMsg
                                                                    .repliedTo ==
                                                                Get.find<
                                                                        UserController>()
                                                                    .user
                                                                    .name
                                                            ? Colors.orange
                                                            : AppColors
                                                                .greyColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height10 -
                                                              5,
                                                    ),
                                                    DisplayTextImageGIF(
                                                      message: repliedMessage,
                                                      type: repliedType,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              DisplayTextImageGIF(
                                                message: message,
                                                type: type,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColors.bgLightColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          Dimensions.height10 -
                                                              5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            repliedMsg.repliedTo ==
                                                                    Get.find<
                                                                            UserController>()
                                                                        .user
                                                                        .name
                                                                ? 'You'
                                                                : repliedMsg
                                                                    .repliedTo,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: repliedMsg
                                                                          .repliedTo ==
                                                                      Get.find<
                                                                              UserController>()
                                                                          .user
                                                                          .name
                                                                  ? Colors
                                                                      .orange
                                                                  : AppColors
                                                                      .greyColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                    .height10 -
                                                                5,
                                                          ),
                                                          Text(
                                                            typeIcon(),
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                      child: SizedBox(
                                                        height: Dimensions
                                                                .height45 +
                                                            5,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              repliedMessage,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 - 5,
                                              ),
                                              DisplayTextImageGIF(
                                                message: message,
                                                type: type,
                                              ),
                                            ],
                                          )
                                    : DisplayTextImageGIF(
                                        message: message,
                                        type: type,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Row(
                            children: [
                              Text(
                                date,
                                style: TextStyle(
                                  fontSize: Dimensions.font16 - 3,
                                  color: Colors.white60,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                isSeen ? Icons.done_all : Icons.done,
                                size: Dimensions.iconSize16 + 4,
                                color: isSeen ? Colors.blue : Colors.white60,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: DisplayTextImageGIF(
                              message: message,
                              type: type,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Row(
                            children: [
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                isSeen ? Icons.done_all : Icons.done,
                                size: 20,
                                color: isSeen ? Colors.blue : Colors.white60,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          )),
    );
  }
}
