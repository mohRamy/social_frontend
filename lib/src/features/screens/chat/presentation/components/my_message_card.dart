import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/src/themes/font_family.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/displaies/display_image_video_card.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../data/models/chat_model.dart';
import 'package:swipe_to/swipe_to.dart';

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
                  horizontal: Dimensions.size15, vertical: Dimensions.size5),
              child: type == "text" || type == "audio"
                  ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.size5,
                            right: Dimensions.size5,
                            top: Dimensions.size5,
                            bottom: Dimensions.size20,
                          ),
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
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: mC.withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    repliedMsg.isMe
                                                        ? 'You'
                                                        : repliedMsg.repliedTo,
                                                    type: TextType.medium,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.size5,
                                                  ),
                                                  DisplayImageVideoCard(
                                                    file: repliedMessage,
                                                    type: repliedType,
                                                    isOut: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: Dimensions.size10),
                                            DisplayImageVideoCard(
                                              file: message,
                                              type: type,
                                              isOut: false,
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
                                                color: mC.withOpacity(0.5),
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
                                                        Dimensions.size5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText(
                                                          repliedMsg.isMe
                                                              ? 'You'
                                                              : repliedMsg
                                                                  .repliedTo,
                                                          type: TextType.medium,
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Dimensions.size5,
                                                        ),
                                                        Text(
                                                          typeIcon(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.white60,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    ),
                                                    child: SizedBox(
                                                      height: 50.sp,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            repliedMessage,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: Dimensions.size5),
                                            DisplayImageVideoCard(
                                              file: message,
                                              type: type,
                                              isOut: false,
                                            ),
                                          ],
                                        )
                                  : DisplayImageVideoCard(
                                      file: message,
                                      type: type,
                                      isOut: false,
                                    ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white60,
                                  fontFamily: FontFamily.lato,
                                ),
                              ),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: isSeen ? colorPrimary : mCL,
                                child: Icon(
                                  Icons.done,
                                  size: Dimensions.size10,
                                  color: isSeen ? mCL : colorPrimary,
                                ),
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
                            child: DisplayImageVideoCard(
                              file: message,
                              type: type,
                              isOut: false,
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
                                  fontSize: 10.sp,
                                  color: Colors.white60,
                                ),
                              ),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: isSeen ? colorPrimary : mCL,
                                child: Icon(
                                  Icons.done,
                                  size: Dimensions.size10,
                                  color: isSeen ? mCL : colorPrimary,
                                ),
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
