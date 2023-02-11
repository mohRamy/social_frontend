// // import 'dart:io';
// // import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_sound/flutter_sound.dart';
// // import 'package:get/get.dart';
// // import 'package:social_app/features/view/chat/controller/chat_ctrl.dart';

// // import '../../../../core/picker/picker.dart';
// // import '../../../../core/utils/app_colors.dart';
// // import '../../../../core/utils/dimensions.dart';
// // import '../../../data/models/chat_model.dart';


// import 'dart:io';

// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:get/get.dart';
// import 'package:social_app/core/picker/picker.dart';
// import 'package:social_app/core/provider/message_reply_provider.dart';
// import 'package:social_app/features/data/models/chat_model.dart';
// import 'package:social_app/features/view/chat/controller/chat_ctrl.dart';
// import 'package:social_app/features/view/chat/widgets/message_reply_preview.dart';

// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/dimensions.dart';

// class BottomChatField extends ConsumerStatefulWidget {
//     final String recieverUserId;
//     final bool isGroupChat;
//     final String username;
//     const BottomChatField({
//       Key? key,
//       required this.recieverUserId,
//       required this.isGroupChat, 
//       required this.username,
//     }) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _BottomChatFieldState();
// }

// class _BottomChatFieldState extends ConsumerState<BottomChatField> {
//   bool isFieldEmpty = true;
//   final TextEditingController _messageC = TextEditingController();
//   FlutterSoundRecorder? _soundRecorder;
//   bool isRecorderInit = false;
//   bool isRecording = false;
//   bool isShowEmojiContainer = false;
//   FocusNode focusNode = FocusNode();

//   @override
//   void initState() {
//     _soundRecorder = FlutterSoundRecorder();
//     // openAudio();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _messageC.dispose();
//     _soundRecorder!.closeRecorder();
//     isRecorderInit = false;
//   }

//   //void openAudio() async {
//   //   final status = await Permission.microphone.request();
//   //   if (status != PermissionStatus.granted) {
//   //     throw RecordingPermissionException('Mic permession not allowed!');
//   //   } else {
//   //     await _soundRecorder!.openRecorder();
//   //     isRecorderInit = true;
//   //   }
//   // }

//   void sendMsg({
//     required String message,
//     required String type,
//     String repliedMessage = '',
//     String repliedType = '',
//   }) async {
//     Get.find<ChatCtrl>().sendMsg(
//       Msg(
//         message: message,
//         type: type,
//       ),
//       RepliedMsg(
//         repliedMessage: repliedMessage,
//         type: repliedType,
//         repliedTo: '',
//         isMe: false,
//       ),
//       widget.recieverUserId,
//       widget.isGroupChat,
//     );
//     setState(() {
//       _messageC.text = '';
//       isFieldEmpty = true;
//     });
//     ref.read(messageReplyProvider.state).update((state) => null);
//   }

//   void selectImage() async {
//     File? image = await pickImageFromGallery();
//     if (image != null) {
//       sendMsg(
//         message: image.path,
//         type: 'image',
//       );
//     }
//   }

//   void selectVideo() async {
//     File? video = await pickVideoFromGallery();
//     if (video != null) {
//       sendMsg(
//         message: video.path,
//         type: 'video',
//       );
//     }
//   }

//   void hideEmojiContainer() {
//     setState(() {
//       isShowEmojiContainer = false;
//     });
//   }

//   void showEmojiContainer() {
//     setState(() {
//       isShowEmojiContainer = true;
//     });
//   }

//   void showKeyboard() => focusNode.requestFocus();
//   void hideKeyboard() => focusNode.unfocus();

//   void toggleEmojiKeyboardContainer() {
//     if (isShowEmojiContainer) {
//       showKeyboard();
//       hideEmojiContainer();
//     } else {
//       hideKeyboard();
//       showEmojiContainer();
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     final messageReply = ref.watch(messageReplyProvider);
//     final showMessageReply = messageReply != null;
//     return Padding(
//           padding: EdgeInsets.all(Dimensions.height10 - 5),
//           child: Column(
//             children: [
//               showMessageReply
//                   ? MessageReplyPreview(
//                       receiverId: widget.recieverUserId,
//                     )
//                   : const SizedBox(),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       focusNode: focusNode,
//                       controller: _messageC,
//                       onChanged: (val) {
//                         if (val.isEmpty) {
//                           setState(() {
//                             isFieldEmpty = true;
//                           });
//                         } else {
//                           setState(() {
//                             isFieldEmpty = false;
//                           });
//                         }
//                       },
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: AppColors.chatBoxOther,
//                         prefixIcon: IconButton(
//                           onPressed: toggleEmojiKeyboardContainer,
//                           icon: Icon(
//                             isShowEmojiContainer
//                                 ? Icons.keyboard
//                                 : Icons.emoji_emotions,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         suffixIcon: SizedBox(
//                           width: isFieldEmpty ? 100 : 5,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(
//                                 onPressed: selectVideo,
//                                 icon: const Icon(
//                                   Icons.attach_file,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               isFieldEmpty
//                                   ? IconButton(
//                                       onPressed: selectImage,
//                                       icon: const Icon(
//                                         Icons.camera_alt,
//                                         color: Colors.grey,
//                                       ),
//                                     )
//                                   : Container()
//                             ],
//                           ),
//                         ),
//                         hintText: 'Message',
//                         border: OutlineInputBorder(
//                           borderRadius: showMessageReply
//                               ? BorderRadius.only(
//                                   bottomLeft:
//                                       Radius.circular(Dimensions.radius20),
//                                   bottomRight:
//                                       Radius.circular(Dimensions.radius20),
//                                 )
//                               : BorderRadius.circular(Dimensions.radius20),
//                           borderSide: const BorderSide(
//                             width: 0,
//                             style: BorderStyle.none,
//                           ),
//                         ),
//                         contentPadding: EdgeInsets.all(Dimensions.height10 - 5),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 5.0,
//                   ),
//                   CircleAvatar(
//                     // radius: 25,
//                     backgroundColor: const Color(0xFF128C7E),
//                     child: GestureDetector(
//                       onTap: () {
//                         sendMsg(
//                           message: _messageC.text.trim(),
//                           type: "text",
//                           repliedMessage: messageReply!.message, 
//                           repliedType: messageReply.type,
//                         );
//                       },
//                       child: Icon(
//                         isFieldEmpty
//                             ? isRecording
//                                 ? Icons.close
//                                 : Icons.mic
//                             : Icons.send,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               isShowEmojiContainer
//                   ? SizedBox(
//                       height: 310,
//                       child: EmojiPicker(
//                         onEmojiSelected: (category, emoji) {
//                           setState(() {
//                             _messageC.text = _messageC.text + emoji.emoji;
//                           });
//                           if (!isFieldEmpty) {
//                             setState(() {
//                               isFieldEmpty = true;
//                             });
//                           }
//                         },
//                       ),
//                     )
//                   : const SizedBox(),
//             ],
//           ),
//         );
//   }
// }

