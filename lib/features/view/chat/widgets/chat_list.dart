import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:social_app/features/data/models/message_model.dart';
import 'package:social_app/features/view/chat/widgets/sender_message_card.dart';

import '../../../../core/enums/message_enum.dart';

class ChatList extends StatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const ChatList({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  // void onMessageSwipe(
  //   String message,
  //   bool isMe,
  //   MessageEnum messageEnum,
  // ) {
  //   ref.read(messageReplyProvider.state).update(
  //         (state) => MessageReply(
  //           message,
  //           isMe,
  //           messageEnum,
  //         ),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
        // stream: widget.isGroupChat
        //     ? ref
        //         .read(chatControllerProvider)
        //         .groupChatStream(widget.recieverUserId)
        //     : ref
        //         .read(chatControllerProvider)
        //         .chatStream(widget.recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Container();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.jm().format(messageData.timeSent);

              // if (!messageData.isSeen &&
              //     messageData.recieverid ==
              //         FirebaseAuth.instance.currentUser!.uid) {
              //   ref.read(chatControllerProvider).setChatMessageSeen(
              //         context,
              //         widget.recieverUserId,
              //         messageData.messageId,
              //       );
              // }
              // if (messageData.senderId ==
              //     FirebaseAuth.instance.currentUser!.uid) {
              //   return MyMessageCard(
              //     message: messageData.text,
              //     date: timeSent,
              //     type: messageData.type,
              //     repliedText: messageData.repliedMessage,
              //     username: messageData.repliedTo,
              //     repliedMessageType: messageData.repliedMessageType,
              //     onLeftSwipe: () => onMessageSwipe(
              //       messageData.text,
              //       true,
              //       messageData.type,
              //     ),
              //     isSeen: messageData.isSeen,
              //   );
              // }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
                username: messageData.repliedTo,
                repliedMessageType: messageData.repliedMessageType,
                // onRightSwipe: () => onMessageSwipe(
                //   messageData.text,
                //   false,
                //   messageData.type,
                // ),
                onRightSwipe: (){},
                repliedText: messageData.repliedMessage,
              );
            },
          );
        });
  }
}