import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/network/api_constance.dart';
import '../controller/chat_controller.dart';
import '../../../../core/picker/picker.dart';
import '../../../../core/provider/message_reply_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../domain/entities/chat.dart';
import 'message_reply_preview.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../auth/presentation/controller/user_controller.dart';
import 'my_message_card.dart';
import 'sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverId;
  final bool isGroupChat;
  final List<Message> userMessages;
  final String username;
  const ChatList({
    Key? key,
    required this.recieverId,
    required this.isGroupChat,
    required this.userMessages,
    required this.username,
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
    usermessages = widget.userMessages;
    initSocketChat();
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
    disconnectSocket();
  }

  List<Message> usermessages = [];

  ///////////////////////////////
  late IO.Socket _socket;

  void initSocketChat() {
      _socket =
        IO.io('${ApiConstance.baseUrl}/socket-chat-message', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    _socket.connect();
    _socket.emit("signin", Get.find<ChatController>().myChat.userId);
    _socket.onConnect((_) {
      _socket.on("message", (msg) {
        setMessage(msg);
        messageController.animateTo(messageController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    _socket.onDisconnect((_) => print('Connection Disconnection'));
    _socket.onConnectError((err) => print(err));
    _socket.onError((err) => print(err));
  }

  void setMessage(Map msg) {
    Message messageModel = Message(
      id: "",
      msg: Msg(
        message: msg["message"],
        type: msg["type"],
      ),
      repliedMsg: RepliedMsg(
        isMe: msg["repliedIsMe"],
        repliedMessage: msg["repliedMessage"],
        type: msg["repliedType"],
        repliedTo: msg["repliedTo"],
      ),
      createdAt: DateTime.now(),
      senderId: msg["senderId"],
      recieverId: msg["recieverId"],
      isSeen: false,
      like: false,
    );
    usermessages.add(messageModel);
    setState(() {});
  }

  void disconnectSocketMessagePersonal() {
    _socket.off('message-personal');
  }

  void disconnectSocket() {
    _socket.disconnect();
  }

  void sendMsgs(
    Msg msg,
    RepliedMsg? repliedMsg,
    String recieverId,
    bool isGroupChat,
  ) async {
    if (msg.type == 'image' || msg.type == 'video') {
      int random = Random().nextInt(1000);
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          msg.message,
          folder: "$random",
        ),
      );
      msg.message = res.secureUrl;
    }

    if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
      int random = Random().nextInt(1000);

      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          repliedMsg.repliedMessage,
          folder: "$random",
        ),
      );
      repliedMsg.repliedMessage = res.secureUrl;
    }
    _socket.emit('message', {
      'senderId': Get.find<ChatController>().myChat.userId,
      'recieverId': recieverId,
      'message': msg.message,
      'type': msg.type,
      'repliedMessage': repliedMsg.repliedMessage,
      'repliedType': repliedMsg.type,
      'repliedTo': repliedMsg.repliedTo,
      'repliedIsMe': repliedMsg.isMe,
    });
  }

  ////////////////////
  void sendMsg({
    required String message,
    required String type,
    String repliedMessage = '',
    String repliedType = '',
  }) async {
    sendMsgs(
      Msg(
        message: message,
        type: type,
      ),
      RepliedMsg(
        repliedMessage: repliedMessage,
        type: repliedType,
        repliedTo: '',
        isMe: false,
      ),
      widget.recieverId,
      widget.isGroupChat,
    );
    setState(() {
      isFieldEmpty = true;
    });
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  /////////////////////////////////////////
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
    ref.read(messageReplyProvider.state).update(
          (state) => MessageReply(
            message,
            isMe,
            type,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    ChatController chatController = Get.find<ChatController>();
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
            itemCount: usermessages.length,
            itemBuilder: (context, index) {
              final messageData = usermessages[index];
              var timeSent = DateFormat.jm().format(messageData.createdAt);

              if (!messageData.isSeen &&
                  messageData.recieverId ==
                      userController.user.id) {
                chatController.chatMessageSeen(widget.recieverId);
              }

              if (messageData.senderId == userController.user.id) {
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
          padding: EdgeInsets.all(Dimensions.height10 - 5),
          child: Column(
            children: [
              showMessageReply
                  ? MessageReplyPreview(
                      receiverId: widget.recieverId,
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
                        fillColor: AppColors.chatBoxOther,
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
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20),
                                )
                              : BorderRadius.circular(Dimensions.radius20),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(Dimensions.height10 - 5),
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
                        chatController.messageNotification(_messageC.text.trim(), widget.recieverId);
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
