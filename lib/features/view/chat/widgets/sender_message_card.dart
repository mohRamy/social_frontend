
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/user_ctrl.dart';
import '../../../data/models/chat_model.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import 'display_text_image_gif.dart';

class SenderMessageCard extends StatelessWidget {
  final Msg msg;
  final String date;
  final VoidCallback onRightSwipe;
  final RepliedMsg repliedMsg;
  

  const SenderMessageCard({
    Key? key,
    required this.msg,
    required this.date,
    required this.onRightSwipe,
    required this.repliedMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message = msg.message!;
    String type = msg.type!;
    String repliedMessage = repliedMsg.repliedMessage!;
    String repliedType = repliedMsg.type!;
    final isReplying = repliedMsg.repliedMessage!.isNotEmpty;
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
      onRightSwipe: onRightSwipe,
      child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: type == 'text' ? 130 : 200,
              maxWidth: 270,
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: AppColors.chatBoxOther,
              margin:  EdgeInsets.symmetric(horizontal: Dimensions.height15, vertical: Dimensions.height10 - 5),
              child: type == 'text' || type == 'audio'
                  ? Stack(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(
                            left: Dimensions.height10 - 5,
                            right: Dimensions.height10 - 5,
                            top: Dimensions.height10,
                            bottom: Dimensions.height20,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isReplying
                                    ? repliedType == 'text' ||
                                            repliedType ==
                                                'audio'
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    EdgeInsets.all(Dimensions.height10 - 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.blackColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                          repliedMsg.repliedTo ==
                                                                  Get.find<UserCtrl>().user.name
                                                              ? repliedMsg.repliedTo!
                                                              : 'You',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                                
                                                            color: repliedMsg.repliedTo ==
                                                                  Get.find<UserCtrl>().user.name
                                                                ? Colors.orange
                                                                : AppColors.blackColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions.height10 - 5,
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
                                                  color: AppColors.blackColor
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
                                                      padding:  EdgeInsets.all(Dimensions.height10 - 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text( 
                                                            repliedMsg.repliedTo ==
                                                                  Get.find<UserCtrl>().user.name
                                                                ? 'You'
                                                                : repliedMsg.repliedTo!,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color:
                                                              repliedMsg.repliedTo ==
                                                                  Get.find<UserCtrl>().user.name
                                                                  ? Colors.orange
                                                                  : AppColors.blackColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions.height10 - 5,
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
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                      child: SizedBox(
                                                        
                                                        height: Dimensions.height45 + 5,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: repliedMessage,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: Dimensions.height10 - 5,),
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
                          bottom: Dimensions.height10 - 5,
                          right: Dimensions.height10 - 5,
                          child: Row(
                            children: [
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white60,
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
                            child: DisplayTextImageGIF(
                              message: message,
                              type: type,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Dimensions.height10 - 5,
                          right: Dimensions.height10 - 5,
                          child: Row(
                            children: [
                              Text(
                                date,
                                style:  TextStyle(
                                  fontSize: Dimensions.font16-4,
                                  color: Colors.white,
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
