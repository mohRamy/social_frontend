
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_colors.dart';

import 'chats_page.dart';
import 'contact_page.dart';
import 'setting_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({ Key? key }) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }
  Widget getBody(){
    return IndexedStack(
      index: pageIndex,
      children: const [
        ContactPage(),
        ChatPage(),
        SettingPage()
      ],
    );
  }
  Widget getFooter(){
    List iconsItems = [
      // MaterialIcons.account_circle,
      // Ionicons.ios_chatbubbles,
      // MaterialIcons.settings,
      Icons.account_circle,
      Icons.chat_bubble,
      Icons.settings,
    ];
    List textItems = [
      "Contacts",
      "Chats",
      "Settings"
    ];
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyColor
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(iconsItems.length, (index) {
            return GestureDetector(
              onTap: (){
                setState(() {
                  pageIndex = index;
                });
              },
              child: Column(
                children: [
                  index == 1 ? Badge(
                    badgeContent: Text("3",style: TextStyle(
                      color:AppColors.white
                    ),
                    
                    ),
                    child:Icon(iconsItems[index],size: 30,color:pageIndex == index ? AppColors.primary :AppColors.white.withOpacity(0.5)) ,
                  ) : Icon(iconsItems[index],size: 30,color:pageIndex == index ? AppColors.primary :AppColors.white.withOpacity(0.5)),
                  const SizedBox(height: 3,),
                  Text(textItems[index],style: TextStyle(fontSize: 11,color:pageIndex == index ? AppColors.primary : AppColors.white.withOpacity(0.5)),)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}