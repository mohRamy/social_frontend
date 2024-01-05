import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../services/socket/socket_emit.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../../taps/home/presentation/components/profile_avatar.dart';
import '../../../auth/data/models/auth_model.dart';
import '../components/chat_list.dart';

class ChatScreen extends StatefulWidget {
  final AuthModel userData;
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
    final AuthModel userData = widget.userData;
    // final List<MessageModel> messages = [];
    // for (var i = 0; i < AppGet.chatGet.contacts.length; i++) {
    //   if (AppGet.chatGet.contacts[i].recieverId == userData.id) {
    //     for (var j = 0; j < AppGet.chatGet.contacts[i].messages.length; j++) {
    //       messages.add( 
    //         AppGet.chatGet.contacts[i].messages[j],
    //       );
    //     }
    //   }
    // }
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
                  AppNavigator.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                      ),
                      ProfileAvatar(
                        imageUrl: userData.photo,
                        sizeImage: 25.sp,
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
                userData.isOnline
                    ? Text(
                        'online'.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Text(
                        'offline'.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      )
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
            onPressed: () {
              AppNavigator.push(
                AppRoutes.voiceCall,
                arguments: {
                  "name": userData.name,
                  "avatar": userData.photo,
                }
              );
            },
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Stack(
        children: [
          ChatList(
            userData: userData,
            isGroupChat: widget.isGroupChat,
            // messagess: messages,
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
      ),
    );
  }
}
