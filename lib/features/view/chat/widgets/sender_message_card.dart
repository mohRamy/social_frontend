
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../core/enums/message_enum.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import 'display_text_image_gif.dart';

class SenderMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  

  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;
    String typeIcon() {
      String contactMsg;
      switch (repliedMessageType) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
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
              minWidth: type == MessageEnum.text ? 130 : 200,
              maxWidth: 270,
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: AppColors.bgBlackColor,
              margin:  EdgeInsets.symmetric(horizontal: Dimensions.height15, vertical: Dimensions.height10 - 5),
              child: type == MessageEnum.text || type == MessageEnum.audio
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
                                    ? repliedMessageType == MessageEnum.text ||
                                            repliedMessageType ==
                                                MessageEnum.audio
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                     EdgeInsets.all(Dimensions.height10 - 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.bgBlackColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(username,
                                                          // username ==
                                                          //         FirebaseAuth
                                                          //             .instance
                                                          //             .currentUser!
                                                          //             .displayName
                                                          //     ? username
                                                          //     : 'You',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                                color: AppColors.bgBlackColor,
                                                            // color: username ==
                                                            //         FirebaseAuth
                                                            //             .instance
                                                            //             .currentUser!
                                                            //             .displayName
                                                            //     ? Colors.orange
                                                            //     : AppColors.bgBlackColor,
                                                          ),
                                                        ),
                                                         SizedBox(
                                                          height: Dimensions.height10 - 5,
                                                        ),
                                                    DisplayTextImageGIF(
                                                      message: repliedText,
                                                      type: repliedMessageType,
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
                                                  color: AppColors.bgBlackColor
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
                                                          Text( username,
                                                            // username ==
                                                            //         FirebaseAuth
                                                            //             .instance
                                                            //             .currentUser!
                                                            //             .displayName
                                                            //     ? 'You'
                                                            //     : username,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: AppColors.bgBlackColor, 
                                                              // username ==
                                                              //         FirebaseAuth
                                                              //             .instance
                                                              //             .currentUser!
                                                              //             .displayName
                                                              //     ? Colors.orange
                                                              //     : AppColors.bgBlackColor,
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
                                                          imageUrl: repliedText,
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
