import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/app_controller.dart';

import '../../data/models/chat_model.dart';
import '../controller/chat_controller.dart';
import '../../../../services/socket/socket_emit.dart';
import '../../../../themes/app_colors.dart';
import '../../../../utils/sizer_custom/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../home/presentation/components/profile_avatar.dart';
import '../components/chat_list.dart';

class ChatScreen extends StatefulWidget {
  final Auth userData;
  final bool isGroupChat;
  const ChatScreen({
    Key? key,
    required this.userData,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    SocketEmit().joinRoomChat(idConversation: 'id-conversation');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Auth userData = widget.userData;
    final List<MessageModel> messages = [];
    for (var i = 0; i < AppGet.chatGet.contentList.length; i++) {
      if (AppGet.chatGet.contentList[i].recieverId == userData.id) {
        for (var j = 0;
            j < AppGet.chatGet.contentList[i].messages.length;
            j++) {
          messages.add(
            AppGet.chatGet.contentList[i].messages[j],
          );
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5.0,
        backgroundColor: chatBoxUser,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(Dimensions.size20),
                onTap: () {
                  AppNavigator.pop;
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                      ),
                      ProfileAvatar(
                        imageUrl: userData.photo,
                        sizeImage: Dimensions.size30,
                      ),
                    ],
                  ),
                )),
            SizedBox(width: Dimensions.size15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData.name),
                // !widget.isGroupChat
                //     ? snapshot.data!.isOnline
                // ?
                Text(
                  'online',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                )
                //     : Container()
                // : Container(),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: GetBuilder<ChatController>(builder: (chatCtrl) {
        return Stack(
          children: [
            ChatList(
              userData: userData,
              isGroupChat: widget.isGroupChat,
              messages: messages,
            ),
            // ),
            // BottomChatField(
            //   recieverUserId: widget.uid,
            //   isGroupChat: widget.isGroupChat,
            //   username: widget.name,
            // ),
            // ],
            // ),
          ],
        );
      }),
    );
  }
}
