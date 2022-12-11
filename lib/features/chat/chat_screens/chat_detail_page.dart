import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../chat_widgets/chat_bubble.dart';
import '../json/chat_json.dart';

class ChatDetailPage extends StatefulWidget {
  final String name;
  final String img;
  const ChatDetailPage({ Key? key,required this.name,required this.img }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      bottomNavigationBar: getBottomBar(),
      body: getBody(),
    );
  }
  Widget getAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.greyColor,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.name,style: TextStyle(
                    fontSize: 17,color: AppColors.white,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("last seen recently",style: TextStyle(
                    fontSize: 12,color: AppColors.white.withOpacity(0.4),
                   
                  ),),
                ],
              ),
            ),
            
          ],
        ),
      ),
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios,color: AppColors.primary,),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.img),
        )
      ],
    );
  }
  Widget getBottomBar(){
    var size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              // Entypo.attachment,
              Icons.attachment,
            color: AppColors.primary,
            size: 21,
            ),
            Container(
              width: size.width*0.76,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TextField(
                  style: TextStyle(
                    color: AppColors.white,
                    
                  ),
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      // MaterialCommunityIcons.sticker_emoji,
                      Icons.emoji_emotions,
                      color: AppColors.primary,size: 25,)
                  ),
                ),
              ),
            ),
            Icon(
              // MaterialCommunityIcons.microphone,
              Icons.microwave,
              color: AppColors.primary,size: 28,)
          ],
        ),
      ),
    );
  }
  Widget getBody(){
    return ListView(
      padding: EdgeInsets.only(top: 20,bottom: 80),
      children: List.generate(messages.length, (index) {
        return CustomBubbleChat(isMe: messages[index]['isMe'], message: messages[index]['message'], time: messages[index]['time'], isLast: messages[index]['isLast']);
      }),
    );
  }
}