import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../controller/app_controller.dart';
import '../../data/models/chat_model.dart';
import '../../../../themes/app_colors.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../utils/sizer_custom/sizer.dart';
import 'display_text_image_gif.dart';

class MyMessageCard extends StatelessWidget {
  final MsgModel msg;
  final String date;
  final VoidCallback onLeftSwipe;
  final RepliedMsgModel repliedMsg;
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
    String userName = AppGet.authGet.userData?.name??'';
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
              color: chatBoxUser,
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.size15,
                  vertical: Dimensions.size5),
              child: type == "text" || type == "audio"
                  ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.size5,
                            right: Dimensions.size5,
                            top: Dimensions.size10,
                            bottom: Dimensions.size20,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: Dimensions.size5),
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
                                                padding: EdgeInsets.all(Dimensions.size5),
                                                decoration: BoxDecoration(
                                                  color: mC
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
                                                              userName
                                                          ? repliedMsg.repliedTo
                                                          : 'You',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: repliedMsg
                                                                    .repliedTo ==
                                                                userName
                                                            ? Colors.orange
                                                            : fCL,
                                                      ),
                                                    ),
                                                    SizedBox(height: Dimensions.size5),
                                                    DisplayTextImageGIF(
                                                      message: repliedMessage,
                                                      type: repliedType,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  height: Dimensions.size10),
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
                                                  color: mC
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
                                                      padding:
                                                          EdgeInsets.all(Dimensions.size5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            repliedMsg.repliedTo ==
                                                                    userName
                                                                ? 'You'
                                                                : repliedMsg
                                                                    .repliedTo,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: repliedMsg
                                                                          .repliedTo ==
                                                                      userName
                                                                  ? Colors
                                                                      .orange
                                                                  : fCL,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: Dimensions.size5),
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
                                                        height: 50.sp,
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
                                              SizedBox(height: Dimensions.size5),
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
                                  fontSize: 13.sp,
                                  color: Colors.white60,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                isSeen ? Icons.done_all : Icons.done,
                                size: Dimensions.size16 + 4,
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
