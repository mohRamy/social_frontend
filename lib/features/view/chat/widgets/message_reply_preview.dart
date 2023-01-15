import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/utils/dimensions.dart';

import '../../../../core/utils/app_colors.dart';


class MessageReplyPreview extends StatelessWidget {
  final String receiverId;
  const MessageReplyPreview({
    required this.receiverId,
    Key? key,
  }) : super(key: key);

  // void cancelReply(WidgetRef ref) {
  //   ref.read(messageReplyProvider.state).update((state) => null);
  // }

  @override
  Widget build(BuildContext context) {
    // final messageReply = ref.watch(messageReplyProvider);
    // String typeIcon() {
    //   String contactMsg;
    //   switch (messageReply!.messageEnum) {
    //     case MessageEnum.image:
    //       contactMsg = '📷 Photo';
    //       break;
    //     case MessageEnum.video:
    //       contactMsg = '📸 Video';
    //       break;
    //     case MessageEnum.audio:
    //       contactMsg = '🎵 Audio';
    //       break;
    //     case MessageEnum.gif:
    //       contactMsg = 'GIF';
    //       break;
    //     default:
    //       contactMsg = 'GIF';
    //   }
    //   return contactMsg;
    // }

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: Dimensions.width30 + 326,
        //356,
        padding:  EdgeInsets.all(Dimensions.height10 -8),
        decoration:  BoxDecoration(
          color: AppColors.bgBlackColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius15 - 3),
            topRight: Radius.circular(Dimensions.radius15 - 3),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius15 - 3),
            color: AppColors.bgBlackColor,
          ),
          padding:
          //  messageReply!.messageEnum == MessageEnum.text
          //     ?  EdgeInsets.all(Dimensions.height10 - 5)
              const EdgeInsets.all(0),
           child: 
           //messageReply.messageEnum == MessageEnum.text
          //     ? 
              // Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding:  EdgeInsets.only(left: Dimensions.height10 - 5),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             // Text(
              //             //   'You',
              //             //   style: TextStyle(
              //             //     fontWeight: FontWeight.bold,
              //             //     color:
              //             //         messageReply.isMe ? AppColors.tabColor : Colors.orange,
              //             //   ),
              //             // ),
              //             // Text(messageReply.message),
              //           ],
              //         ),
              //       ),
              //       GestureDetector(
              //         child: CircleAvatar(
              //           backgroundColor: Colors.white,
              //           radius: Dimensions.radius15 - 7,
              //           child: Icon(
              //             Icons.close,
              //             size: Dimensions.iconSize16 - 4,
              //           ),
              //         ),
              //         onTap: (){},
              //         // onTap: () => cancelReply(ref),
              //       ),
              //     ],
              //   )
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.height10 - 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   messageReply.isMe ? 'You' : 'he',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     color:
                          //         messageReply.isMe ? AppColors.bgBlackColor : Colors.orange,
                          //   ),
                          // ),
                          // Text(typeIcon()),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius15 - 7),
                            bottomRight: Radius.circular(Dimensions.radius15 - 7),
                          ),
                          child: Container(),
                          // child: SizedBox(
                          //   height: 50,
                          //   child: CachedNetworkImage(
                          //       imageUrl: messageReply.message),
                          // ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: Dimensions.radius15 - 7,
                              child: Icon(
                                Icons.close,
                                size: Dimensions.iconSize16 - 4,
                              ),
                            ),
                            onTap: (){},
                            // onTap: () => cancelReply(ref),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
