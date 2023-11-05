import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:social_app/src/resources/local/user_local.dart';
import '../../../../controller/app_controller.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../data/models/chat_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../utils/sizer_custom/sizer.dart';
import '../controller/chat_controller.dart';
import '../../../../core/picker/picker.dart';
import '../../../../core/provider/message_reply_provider.dart';
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
  final ScrollController messageController = ScrollController();
  bool isFieldEmpty = true;
  final TextEditingController _messageC = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isRecording = false;
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    _soundRecorder = FlutterSoundRecorder();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    _messageC.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  void sendMsg({
    required String message,
    required String type,
    String repliedMessage = '',
    String repliedType = '',
  }) {
    AppGet.chatGet.addMessage(
      UserLocal().getUserId(),
      widget.userData.id,
      MsgModel(
        message: message,
        type: type,
      ),
      RepliedMsgModel(
        repliedMessage: repliedMessage,
        type: repliedType,
        repliedTo: '',
        isMe: false,
      ),
    );
    messageController.animateTo(messageController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    setState(() {
      isFieldEmpty = true;
    });
    // ref.read(messageReplyProvider.state).update((state) => null);
  }

  /////////////////////////////////////////
  ///
  void selectImage() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      sendMsg(
        message: image.path,
        type: 'image',
      );
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      sendMsg(
        message: video.path,
        type: 'video',
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
    // ref.read(messageReplyProvider.state).update(
    //       (state) => MessageReply(
    //         message,
    //         isMe,
    //         type,
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    String userId = AppGet.authGet.userData?.id??'';
    ChatController chatController = AppGet.chatGet;
    final messageReply = ref.watch(messageReplyProvider);
    final showMessageReply = messageReply != null;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messageController.jumpTo(messageController.position.maxScrollExtent);
    });

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: messageController,
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              final messageData = widget.messages[index];
              var timeSent = DateFormat.jm().format(messageData.createdAt!);

              if (!messageData.isSeen && messageData.recieverId == userId) {
                chatController.chatMessageSeen(widget.userData.id);
              }

              if (messageData.senderId == userId) {
                return MyMessageCard(
                  date: timeSent,
                  msg: messageData.msg,
                  repliedMsg: messageData.repliedMsg,
                  onLeftSwipe: () => onMessageSwipe(
                    messageData.msg.message,
                    true,
                    messageData.msg.type,
                  ),
                  isSeen: messageData.isSeen,
                );
              }
              return SenderMessageCard(
                date: timeSent,
                msg: messageData.msg,
                repliedMsg: messageData.repliedMsg,
                onRightSwipe: () => onMessageSwipe(
                  messageData.msg.message,
                  false,
                  messageData.msg.type,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(Dimensions.size5),
          child: Column(
            children: [
              showMessageReply
                  ? MessageReplyPreview(
                      receiverId: widget.userData.id,
                    )
                  : const SizedBox(),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                        hintText: 'Message',
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
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CircleAvatar(
                    // radius: 25,
                    backgroundColor: const Color(0xFF128C7E),
                    child: GestureDetector(
                      onTap: () {
                        sendMsg(
                          message: _messageC.text.trim(),
                          type: "text",
                          repliedMessage: messageReply?.message ?? "",
                          repliedType: messageReply?.type ?? "",
                        );
                        chatController.messageNotification(
                          widget.userData.id,
                          _messageC.text.trim(),
                        );
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
