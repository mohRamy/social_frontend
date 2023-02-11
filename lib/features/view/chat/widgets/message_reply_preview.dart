import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/core/provider/message_reply_provider.dart';
import 'package:social_app/core/utils/app_colors.dart';

import '../../../../core/utils/dimensions.dart';

class MessageReplyPreview extends ConsumerWidget {
  final String receiverId;
  const MessageReplyPreview({
    required this.receiverId,
    Key? key,
  }) : super(key: key);

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);
    String typeIcon() {
      String contactMsg;
      switch (messageReply!.type) {
        case "image":
          contactMsg = '📷 Photo';
          break;
        case "video":
          contactMsg = '📸 Video';
          break;
        case "audio":
          contactMsg = '🎵 Audio';
          break;
        case "gif":
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      return contactMsg;
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: Dimensions.width30 + 324,
        //356,
        padding:  EdgeInsets.all(Dimensions.height10 -8),
        decoration:  BoxDecoration(
          color: AppColors.bgDarkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius15 - 3),
            topRight: Radius.circular(Dimensions.radius15 - 3),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius15 - 3),
            color: AppColors.bgLightColor,
          ),
          padding: messageReply!.type == "text"
              ?  EdgeInsets.all(Dimensions.height10 - 5)
              : const EdgeInsets.all(0),
          child: messageReply.type == "text"
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.height10 - 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  messageReply.isMe ? AppColors.bgLightColor : Colors.orange,
                            ),
                          ),
                          Text(messageReply.message),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: Dimensions.radius15 - 7,
                        child: Icon(
                          Icons.close,
                          size: Dimensions.iconSize16 - 4,
                        ),
                      ),
                      onTap: () => cancelReply(ref),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.height10 - 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messageReply.isMe ? 'You' : 'he',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  messageReply.isMe ? AppColors.bgLightColor : Colors.orange,
                            ),
                          ),
                          Text(typeIcon()),
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
                          child: SizedBox(
                            height: 50,
                            child: CachedNetworkImage(
                                imageUrl: messageReply.message),
                          ),
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
                            onTap: () => cancelReply(ref),
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
