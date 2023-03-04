import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/chat.dart';
import '../controller/chat_controller.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/components/profile_avatar.dart';
import '../components/chat_list.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String name;
  final String photo;
  final bool isGroupChat;
  const ChatScreen({
    Key? key,
    required this.userId,
    required this.name,
    required this.photo,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Chat chatModel = Get.find<ChatController>().myChat;
    List<Message> userMessages = [];
    if (chatModel.contents.isNotEmpty) {
      for (var i = 0; i < chatModel.contents.length; i++) {
        if (chatModel.contents[i].recieverId == widget.userId) {
          for (var j = 0; j < chatModel.contents[i].messages.length; j++) {
            userMessages.add(chatModel.contents[i].messages[j]);
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5.0,
        backgroundColor: AppColors.chatBoxMe,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                      ),
                      ProfileAvatar(
                        imageUrl: widget.photo,
                        sizeImage: Dimensions.height30,
                      ),
                    ],
                  ),
                )),
            SizedBox(width: Dimensions.width15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name),
                // !widget.isGroupChat
                //     ? snapshot.data!.isOnline
                // ?
                Text(
                  'online',
                  style: TextStyle(
                    fontSize: Dimensions.font16 - 3,
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
      body: Stack(
        children: [
          ChatList(
            recieverId: widget.userId,
            isGroupChat: widget.isGroupChat,
            userMessages: userMessages,
            username: widget.name,
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
