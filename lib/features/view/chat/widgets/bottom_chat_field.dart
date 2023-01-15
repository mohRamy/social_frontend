import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../core/picker/picker.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';


class BottomChatField extends StatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool isFieldEmpty = true;
  final TextEditingController _messageC = TextEditingController();
  // FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isRecording = false;
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

  // @override
  // void initState() {
  //   _soundRecorder = FlutterSoundRecorder();
  //   openAudio();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _messageC.dispose();
  //   _soundRecorder!.closeRecorder();
  //   isRecorderInit = false;
  //   super.dispose();
  // }

  // void openAudio() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw RecordingPermissionException('Mic permession not allowed!');
  //   } else {
  //     await _soundRecorder!.openRecorder();
  //     isRecorderInit = true;
  //   }
  // }

  // void sendTextMessage() async {
  //   if (!isFieldEmpty) {
  //     ref.read(chatControllerProvider).sendTextMessage(
  //           Dimensions,
  //           _messageC.text.trim(),
  //           widget.recieverUserId,
  //           widget.isGroupChat,
  //         );
  //     setState(() {
  //       _messageC.text = '';
  //     });
  //   } else {
  //     var tempDir = await getTemporaryDirectory();
  //     var path = '${tempDir.path}/flutter_sound.aac';
  //     if (!isRecorderInit) {
  //       return;
  //     }
  //     if (isRecording) {
  //       await _soundRecorder!.stopRecorder();
  //       sendFileMessage(File(path), MessageEnum.audio);
  //     } else {
  //       await _soundRecorder!.startRecorder(
  //         toFile: path,
  //       );
  //     }

  //     setState(() {
  //       isRecording = !isRecording;
  //     });
  //   }
  // }

  // void sendFileMessage(File file, MessageEnum messageEnum) {
  //   ref.read(chatControllerProvider).sendFileMessage(
  //         Dimensions,
  //         file,
  //         widget.recieverUserId,
  //         messageEnum,
  //         widget.isGroupChat,
  //       );
  // }

  void selectImage() async {
    File? image = await pickImageFromGallery();
    // if (image != null) {
    //   sendFileMessage(
    //     image,
    //     MessageEnum.image,
    //   );
    // }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      // sendFileMessage(
      //   video,
      //   MessageEnum.video,
      // );
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

  @override
  Widget build(BuildContext context) {
    // final messageReply = ref.watch(messageReplyProvider);
    // final showMessageReply = messageReply != null;
    return Padding(
      padding:  EdgeInsets.all(Dimensions.height10 - 5),
      child: Column(
        children: [
          // showMessageReply
          //     ? MessageReplyPreview(
          //         receiverId: widget.recieverUserId,
          //       )
             // : 
              const SizedBox(),
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
                    fillColor: AppColors.bgBlackColor,
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
                      borderRadius: 
                      // showMessageReply
                      //     ? BorderRadius.only(
                      //         bottomLeft: Radius.circular(Dimensions.radius20),
                      //         bottomRight: Radius.circular(Dimensions.radius20),
                      //       )
                      //     : 
                          BorderRadius.circular(Dimensions.radius20),
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
                  onTap: (){},
                  // sendTextMessage,
                  child: Icon(
                    isFieldEmpty
                        ? isRecording
                            ? Icons.close
                            : Icons.mic
                        : 
                        Icons.send,
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
                      if (!isFieldEmpty) {
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
    );
  }
}
