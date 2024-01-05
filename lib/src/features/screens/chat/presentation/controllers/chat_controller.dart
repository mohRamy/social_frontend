import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/enums/type_enum.dart';
import '../../../../../core/picker/picker.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../core/widgets/app_clouding.dart';
import '../../data/models/chat_model.dart';
import '../../domain/usecases/add_message.dart';

import '../../domain/usecases/is_message_seen.dart';
import '../../domain/usecases/get_user_chat.dart';
import '../screens/image_screen.dart';

class ChatController extends GetxController with HandleLoading {
  final GetUserChatUseCase getUserChatUseCase;
  final AddMessageUseCase addMessageUseCase;
  final IsMessageSeenUseCase chatMessageSeenUseCase;

  ChatController(
    this.getUserChatUseCase,
    this.addMessageUseCase,
    this.chatMessageSeenUseCase,
  );

  final ScrollController messageController = ScrollController();
  late TextEditingController messageC;

  List<ContactModel> contacts = <ContactModel>[];
  // List<Map<String, ContactModel>> contactLis = [];

  // List<MessageModel> messages = [];

  Map<String, String> idConversation = {};

  RxBool isFieldEmpty = true.obs;

  FlutterSoundRecorder? soundRecorder;
  bool isRecorderInit = false;
  bool isRecording = false;

  @override
  void onInit() {
    messageC = TextEditingController();
    // messages = [];
    // for (var i = 0; i < widget.messages.length; i++) {
    //   messages.add(widget.messages[i]);
    // }
    soundRecorder = FlutterSoundRecorder();
    super.onInit();
  }

  @override
  void onClose() {
    soundRecorder!.closeRecorder();
    isRecorderInit = false;
    super.onClose();
  }

  @override
  void dispose() {
    messageC.dispose();
    messageController.dispose();
    super.dispose();
  }

  String selectedImage = "";

  void selectImage(String userId) async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      Get.to(ImageVideoScreen(
        message: image,
        messageType: TypeEnum.image,
        userId: userId,
      ));
      selectedImage = image.path;
    }
  }

  void selectVideo(String userId) async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      Get.to(ImageVideoScreen(
        message: video,
        messageType: TypeEnum.video,
        userId: userId,
      ));
      selectedImage = video.path;
    }
  }

  void getUserChat() async {
    final result = await getUserChatUseCase();
    result.fold(
      (l) => handleLoading(l),
      (r) {
        contacts = r.contacts;
        // for (var i = 0; i < r.contents.length; i++) {
        //   contentList.add(r.contents[i]);
        // }
      },
    );
  }

  FutureOr<void> addMessage(
    String senderId,
    String recieverId,
    MsgModel msg,
    RepliedMsgModel? repliedMsg,
  ) async {
    messageC.text = "";
    isFieldEmpty.value = true;

    if (msg.type == 'image' || msg.type == 'video') {
      msg.messageImage = await cloudinaryPublic(selectedImage);
    }

    if (repliedMsg?.type == 'image' || repliedMsg?.type == 'video') {
      repliedMsg?.repliedMessage =
          await cloudinaryPublic(repliedMsg.repliedMessage);
    }

    MessageModel message = MessageModel(
      senderId: senderId,
      recieverId: recieverId,
      msg: msg,
      repliedMsg: repliedMsg!,
      createdAt: DateTime.now(),
    );

    for (var i = 0; i < contacts.length; i++) {
      if (contacts[i].recieverId == recieverId) {
        contacts[i].messages.add(message);
      }
    }

    final result = await addMessageUseCase(
      "id-conversation",
      message,
    );

    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    scrollToBottom();

    update();
  }

  void addedMessage(dynamic data) async {
    ContactModel contact = ContactModel.fromMap(data);

    int existingIndex =
        contacts.indexWhere((element) => element.id == contact.id);

    if (existingIndex != -1) {
      contacts[existingIndex] = contact;
    } else {
      contacts.add(contact);
    }

    contacts = contacts.toSet().toList();

    scrollToBottom();
    update();
  }

  void scrollToBottom() {
    messageController.animateTo(
      messageController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messageController.jumpTo(messageController.position.maxScrollExtent);
    });
  }

  // void addedMessage(dynamic data) async {
  //   // contacts.clear();
  //   // List rawData = data;

  //   print(data);
  //   ContactModel contact = ContactModel.fromMap(data);
  //   print(contact);

  //   contacts[contacts.indexOf(contact)] = contact;

  //   // contacts = rawData.map((e) => ContactModel.fromMap(e)).toList();

  //   if (contact.recieverId == UserLocal().getUserId()) {
  //     contacts.removeWhere((element) => element.id == contact.id);
  //     contacts.add(contact);
  //   }

  //   messageController.animateTo(messageController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     messageController.jumpTo(messageController.position.maxScrollExtent);
  //   });
  //   update();
  // }

  void isMessageSeen(String recieverId) async {
    final result = await chatMessageSeenUseCase(recieverId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
  }

  void isedMessageSeen(dynamic data) async {
    for (var i = 0; i < contacts.length; i++) {
      if (contacts[i].recieverId == data) {
        for (var j = 0; j < contacts[i].messages.length; j++) {
          if (contacts[i].messages[j].senderId == UserLocal().getUserId() &&
              !contacts[i].messages[j].isSeen) {
            contacts[i].messages[j].isSeen = true;
          }
        }
      }
    }
    update();
  }

  void messageTextEmojy(Emoji emoji) {
    messageC.text = messageC.text + emoji.emoji;
    update();
  }

  RxBool isShowEmojiContainer = false.obs;
  FocusNode focusNode = FocusNode();

  void hideEmojiContainer() {
    isShowEmojiContainer.value = false;
    update();
  }

  void showEmojiContainer() {
    isShowEmojiContainer.value = true;
    update();
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer.value) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  void changeField(String val) {
    if (val.isEmpty) {
      isFieldEmpty.value = true;
    } else {
      isFieldEmpty.value = false;
    }
  }

  void changeFieldToTrue() {
    isFieldEmpty.value = true;
    update();
  }

  // void messageNotification(String userId, String message) async {
  //   final result = await messageNotificationUseCase(userId, message);
  //   result.fold(
  //     (l) => handleLoading(l),
  //     (r) => null,
  //   );
  // }
}
