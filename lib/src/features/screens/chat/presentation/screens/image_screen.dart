import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/enums/type_enum.dart';
import 'package:social_app/src/features/screens/chat/index.dart';
import 'package:social_app/src/routes/app_pages.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';

import '../../../../../core/displaies/display_file_message.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../themes/app_colors.dart';
import '../../data/models/chat_model.dart';

class ImageVideoScreen extends GetView<ChatController> {
  final File? message;
  final TypeEnum messageType;
  final String userId;
  const ImageVideoScreen({
    super.key,
    required this.message,
    required this.messageType,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplayFileMessage(
              file: message!,
              type: messageType,
            ),
            // Padding(
            //   padding: EdgeInsets.all(Dimensions.size5),
            //   child: GetBuilder<ChatController>(builder: (chatCtrl) {
            //     return Column(
            //       children: [
            //         Row(
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Expanded(
            //               child: Column(
            //                 children: [
            //                   TextFormField(
            //                     focusNode: chatCtrl.focusNode,
            //                     controller: chatCtrl.messageC,
            //                     onChanged: (val) {
            //                       chatCtrl.changeField(val);
            //                     },
            //                     decoration: InputDecoration(
            //                       filled: true,
            //                       fillColor: chatBoxOther,
            //                       prefixIcon: Obx(
            //                         ()=> IconButton(
            //                           onPressed:
            //                               controller.toggleEmojiKeyboardContainer,
            //                           icon: Icon(
            //                             controller.isShowEmojiContainer.value
            //                                 ? Icons.keyboard
            //                                 : Icons.emoji_emotions,
            //                             color: Colors.grey,
            //                           ),
            //                         ),
            //                       ),
            //                       hintText: 'add explination',
            //                       border: OutlineInputBorder(
            //                         borderRadius:
            //                             BorderRadius.circular(Dimensions.size20),
            //                         borderSide: const BorderSide(
            //                           width: 0,
            //                           style: BorderStyle.none,
            //                         ),
            //                       ),
            //                       contentPadding:
            //                           EdgeInsets.all(Dimensions.size5),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             const SizedBox(
            //               width: 5.0,
            //             ),
            //             CircleAvatar(
            //               backgroundColor: const Color(0xFF128C7E),
            //               child: GestureDetector(
            //                 onTap: () {
            //                   chatCtrl.addMessage(
            //                     UserLocal().getUserId(),
            //                     userId,
            //                     MsgModel(
            //                       message: chatCtrl.messageC.text.trim(),
            //                       type: "image",
            //                     ),
            //                     RepliedMsgModel(
            //                       repliedMessage: "",
            //                       type: "",
            //                       isMe: false,
            //                       repliedTo: "",
            //                     ),
            //                   );
            //                   AppNavigator.pop();
            //                 },
            //                 child: Obx(
            //                   () => Icon(
            //                     chatCtrl.isFieldEmpty.value
            //                         ? Icons.mic
            //                         : Icons.send,
            //                     color: Colors.white,
            //                     size: 20,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //         Obx(
            //           () => controller.isShowEmojiContainer.value
            //               ? SizedBox(
            //                   height: 310,
            //                   child: EmojiPicker(
            //                       onEmojiSelected: (category, emoji) {
            //                         chatCtrl.messageTextEmojy(emoji);
            //                         if (chatCtrl.isFieldEmpty.value) {
            //                           chatCtrl.changeFieldToTrue();
            //                         }
            //                       },
            //                   ),
            //                 )
            //               : const SizedBox(),
            //         ),
            //       ],
            //     );
            //   }),
            // ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.size20,
        ),
        child: GetBuilder<ChatController>(builder: (chatCtrl) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
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
                                    controller.toggleEmojiKeyboardContainer,
                                icon: Icon(
                                  controller.isShowEmojiContainer.value
                                      ? Icons.keyboard
                                      : Icons.emoji_emotions,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            hintText: 'add explination',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size20),
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
                            type: "image",
                          ),
                          RepliedMsgModel(
                            repliedMessage: "",
                            type: "",
                            isMe: false,
                            repliedTo: "",
                          ),
                        );
                        AppNavigator.pop();
                      },
                      child: Obx(
                        () => const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.isShowEmojiContainer.value
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
    );
  }
}
