import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../helper/date_time_helper.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../controller/app_controller.dart';
import '../../../../../core/provider/message_reply_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/font_family.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../data/models/chat_model.dart';
import '../controllers/chat_controller.dart';
import 'message_reply_preview.dart';

import 'my_message_card.dart';
import 'sender_message_card.dart';

class ChatList extends ConsumerWidget {
  final AuthModel userData;
  final bool isGroupChat;
  // final List<MessageModel> messagess;
  const ChatList({
    Key? key,
    required this.userData,
    required this.isGroupChat,
    // required this.messagess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String userId = userData.id;
    String localUserId = UserLocal().getUserId();
    List<MessageModel> messages = [];

      void onMessageSwipe(
    String message,
    bool isMe,
    String type,
  ) { 
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(
            message,
            isMe,
            type,
            userData.name,
          ),
        );
  }


    final messageReply = ref.watch(messageReplyProvider);
    final showMessageReply = messageReply != null;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppGet.chatGet.messageController
          .jumpTo(AppGet.chatGet.messageController.position.maxScrollExtent);
    });

    // for (var i = 0; i < messages.length; i++) {
    //   AppGet.chatGet.messages.add(messages[i]);
    // }

    return Column(
      children: [
        Expanded(
          child: GetBuilder<ChatController>(builder: (chatCtrl) {
            for (var i = 0; i < chatCtrl.contacts.length; i++) {
              if (chatCtrl.contacts[i].recieverId == userId) {
                messages.clear();
                for (var j = 0; j < chatCtrl.contacts[i].messages.length; j++) {
                  messages.add(chatCtrl.contacts[i].messages[j]);
                }
              }
            }

            if (messages.isNotEmpty) {
              if (messages.last.senderId != UserLocal().getUserId() &&
                  !messages.last.isSeen) {
                chatCtrl.isMessageSeen(userId);
                for (var i = 0; i < chatCtrl.contacts.length; i++) {
                  if (chatCtrl.contacts[i].recieverId == userId) {
                    for (var j = 0;
                        j < chatCtrl.contacts[i].messages.length;
                        j++) {
                      if (chatCtrl.contacts[i].messages[j].senderId !=
                              UserLocal().getUserId() &&
                          !chatCtrl.contacts[i].messages[j].isSeen) {
                        chatCtrl.contacts[i].messages[j].isSeen = true;
                      }
                    }
                  }
                }
              }
            }

            Map<DateTime, List<MessageModel>> groupedMessages = {};
            for (var message in messages) {
              // Truncate time to get only the date
              DateTime truncatedDate = DateTime(
                message.createdAt.year,
                message.createdAt.month,
                message.createdAt.day,
              );

              if (!groupedMessages.containsKey(truncatedDate)) {
                groupedMessages[truncatedDate] = [];
              }

              groupedMessages[truncatedDate]!.add(message);
            }

            List<Widget> dateGroups = [];
            groupedMessages.forEach((date, messages) {
              dateGroups.add(
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: chatBoxOther,
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.size15,
                            vertical: Dimensions.size5),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.size5,
                              vertical: Dimensions.size5),
                          child: Text(
                            DateFormat('MMMM d, y').format(date),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white60,
                              fontFamily: FontFamily.lato,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: messages.map((message) {
                        var timeSent = timeAgoCustom(message.createdAt);
                        return message.senderId == localUserId
                            ? MyMessageCard(
                                date: timeSent,
                                msg: message.msg,
                                repliedMsg: message.repliedMsg,
                                onLeftSwipe: () => onMessageSwipe(
                                  message.msg.message,
                                  true,
                                  message.msg.type,
                                ),
                                isSeen: message.isSeen,
                              )
                            : SenderMessageCard(
                                date: timeSent,
                                msg: message.msg,
                                repliedMsg: message.repliedMsg,
                                onRightSwipe: () => onMessageSwipe(
                                  message.msg.message,
                                  false,
                                  message.msg.type,
                                ),
                              );
                      }).toList(),
                    ),
                  ],
                ),
              );
            });

            return ListView.builder(
              controller: chatCtrl.messageController,
              itemCount: dateGroups.length,
              itemBuilder: (context, index) {
                return Column(
                  children: dateGroups,
                );
              },
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.all(Dimensions.size5),
          child: GetBuilder<ChatController>(builder: (chatCtrl) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          showMessageReply
                              ? MessageReplyPreview(
                                  receiverId: userId,
                                )
                              : const SizedBox(),
                          TextFormField(
                            focusNode: chatCtrl.focusNode,
                            controller: chatCtrl.messageC,
                            onChanged: (val) {
                              chatCtrl.changeField(val);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: chatBoxOther,
                              prefixIcon: Obx(
                                () => IconButton(
                                  onPressed:
                                      chatCtrl.toggleEmojiKeyboardContainer,
                                  icon: Icon(
                                    chatCtrl.isShowEmojiContainer.value
                                        ? Icons.keyboard
                                        : Icons.emoji_emotions,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              suffixIcon: Obx(
                                () => SizedBox(
                                  width: chatCtrl.isFieldEmpty.value ? 100 : 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () => chatCtrl
                                            .selectVideo(userId),
                                        icon: const Icon(
                                          Icons.attach_file,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      chatCtrl.isFieldEmpty.value
                                          ? IconButton(
                                              onPressed: () =>
                                                  chatCtrl.selectImage(
                                                      userId),
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              hintText: 'send_message'.tr,
                              border: OutlineInputBorder(
                                borderRadius: showMessageReply
                                    ? BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(Dimensions.size20),
                                        bottomRight:
                                            Radius.circular(Dimensions.size20),
                                      )
                                    : BorderRadius.circular(Dimensions.size20),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(Dimensions.size5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    CircleAvatar(
                      backgroundColor: const Color(0xFF128C7E),
                      child: GestureDetector(
                        onTap: () {
                          chatCtrl.addMessage(
                            UserLocal().getUserId(),
                            userId,
                            MsgModel(
                              message: chatCtrl.messageC.text.trim(),
                              type: "text",
                            ),
                            RepliedMsgModel(
                              repliedMessage: messageReply?.message ?? "",
                              type: messageReply?.type ?? "",
                              isMe: messageReply?.isMe ?? false,
                              repliedTo: messageReply?.repliedTo ?? "",
                            ),
                          );
                          ref.read(messageReplyProvider.notifier).update((state) => null);
                        },
                        child: Obx(
                          () => Icon(
                            chatCtrl.isFieldEmpty.value
                                ? chatCtrl.isRecording
                                    ? Icons.close
                                    : Icons.mic
                                : Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => chatCtrl.isShowEmojiContainer.value
                      ? SizedBox(
                          height: 310,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              chatCtrl.messageTextEmojy(emoji);
                              if (chatCtrl.isFieldEmpty.value) {
                                chatCtrl.changeFieldToTrue();
                              }
                            },
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
