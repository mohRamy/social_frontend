import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../helper/date_time_helper.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../controller/app_controller.dart';
import '../../../../../core/picker/picker.dart';
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

class ChatList extends ConsumerStatefulWidget {
  final AuthModel userData;
  final bool isGroupChat;
  final List<MessageModel> messages;
  const ChatList({
    Key? key,
    required this.userData,
    required this.isGroupChat,
    required this.messages,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  bool isFieldEmpty = true;
  final TextEditingController _messageC = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isRecording = false;
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    AppGet.chatGet.messages = [];
    for (var i = 0; i < widget.messages.length; i++) {
      AppGet.chatGet.messages.add(widget.messages[i]);
    }
    _soundRecorder = FlutterSoundRecorder();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _messageC.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  void sendMsg({
    required MsgModel msg,
    RepliedMsgModel? repliedMsg,
  }) {
    AppGet.chatGet.messages.add(
      MessageModel(
        senderId: UserLocal().getUserId(),
        recieverId: widget.userData.id,
        msg: msg,
        repliedMsg: repliedMsg??RepliedMsgModel(repliedMessage: "", type: "", repliedTo: "", isMe: false,),
        createdAt: DateTime.now(),
      ),
    );
    AppGet.chatGet.addMessage(
      UserLocal().getUserId(),
      widget.userData.id,
      msg,
      repliedMsg,
    );
    AppGet.chatGet.messageController.animateTo(
        AppGet.chatGet.messageController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
    setState(() {
      isFieldEmpty = true;
    });
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void selectImage() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      print(image.path);
      sendMsg(
        msg: MsgModel(
          message: image.path,
          type: 'image',
        ),
      );
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      sendMsg(
        msg: MsgModel(
          message: video.path,
          type: 'video',
        ),
      );
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

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
            widget.userData.name,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    String userId = UserLocal().getUserId();
    List<MessageModel> messages = [];

    final messageReply = ref.watch(messageReplyProvider);
    final showMessageReply = messageReply != null;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppGet.chatGet.messageController
          .jumpTo(AppGet.chatGet.messageController.position.maxScrollExtent);
    });

    return Column(
      children: [
        Expanded(
          child: GetBuilder<ChatController>(builder: (chatCtrl) {
            for (var i = 0; i < chatCtrl.contacts.length; i++) {
              if (chatCtrl.contacts[i].recieverId == widget.userData.id) {
                messages.clear();
                for (var j = 0;
                    j < chatCtrl.contacts[i].messages.length;
                    j++) {
                  messages.add(chatCtrl.contacts[i].messages[j]);
                }
              }
            }

            if (messages.isNotEmpty) {
              if (messages.last.senderId != UserLocal().getUserId() &&
                !messages.last.isSeen) {
              chatCtrl.isMessageSeen(widget.userData.id);
              for (var i = 0; i < chatCtrl.contacts.length; i++) {
                if (chatCtrl.contacts[i].recieverId == widget.userData.id) {
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
                        return message.senderId == userId
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
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        showMessageReply
                            ? MessageReplyPreview(
                                receiverId: widget.userData.id,
                              )
                            : const SizedBox(),
                        TextFormField(
                          focusNode: focusNode,
                          controller: _messageC,
                          onChanged: (val) {
                            if (val.isEmpty) {
                              setState(() {
                                isFieldEmpty = true;
                              });
                            } else {
                              setState(() {
                                isFieldEmpty = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: chatBoxOther,
                            prefixIcon: IconButton(
                              onPressed: toggleEmojiKeyboardContainer,
                              icon: Icon(
                                isShowEmojiContainer
                                    ? Icons.keyboard
                                    : Icons.emoji_emotions,
                                color: Colors.grey,
                              ),
                            ),
                            suffixIcon: SizedBox(
                              width: isFieldEmpty ? 100 : 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: selectVideo,
                                    icon: const Icon(
                                      Icons.attach_file,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  isFieldEmpty
                                      ? IconButton(
                                          onPressed: selectImage,
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey,
                                          ),
                                        )
                                      : Container()
                                ],
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
                        sendMsg(
                          msg: MsgModel(
                            message: _messageC.text.trim(),
                            type: "text",
                          ),
                          repliedMsg: RepliedMsgModel(
                            repliedMessage: messageReply?.message ?? "",
                            type: messageReply?.type ?? "",
                            isMe: messageReply?.isMe ?? false,
                            repliedTo: messageReply?.repliedTo ?? "",
                          ),
                        );
                        // chatController.messageNotification(
                        //   widget.userData.id,
                        //   _messageC.text.trim(),
                        // );
                        setState(() {
                          _messageC.text = "";
                        });
                      },
                      child: Icon(
                        isFieldEmpty
                            ? isRecording
                                ? Icons.close
                                : Icons.mic
                            : Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              isShowEmojiContainer
                  ? SizedBox(
                      height: 310,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          setState(() {
                            _messageC.text = _messageC.text + emoji.emoji;
                          });
                          if (isFieldEmpty) {
                            setState(() {
                              isFieldEmpty = true;
                            });
                          }
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
