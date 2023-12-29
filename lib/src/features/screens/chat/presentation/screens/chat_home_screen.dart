import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import '../../../../../themes/font_family.dart';

import '../../../../../core/picker/picker.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../components/contacts_list.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<ChatHomeScreen>
    with TickerProviderStateMixin {
  File? image;
  void pickImageGallery() async {
    image = await pickImageFromGallery();

    // Components.navigateTo(
    //   context,
    //   Routes.confirmStatusScreen,
    //   image,
    // );
    setState(() {});
  }

  void pickImageCamera() async {
    image = await pickImageFromCamera();
    // Components.navigateTo(
    //   context,
    //   Routes.confirmStatusScreen,
    //   image,
    // );
    setState(() {});
  }

  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Text(
            "chat".tr,
            style: TextStyle(
              fontSize: Dimensions.size20,
              color: Get.isDarkMode ? mCL : colorBlack,
              fontFamily: FontFamily.lato,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: AppText(
                    'create_group'.tr,
                    type: TextType.medium,
                  ),
                  onTap: () => Future(
                    () {},
                    // () => Navigator.pushNamed(
                    //   context,
                    //   Routes.createGroupScreen,
                    // ),
                  ),
                )
              ],
            ),
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: colorBlack,
            indicatorWeight: 4,
            labelColor: colorBlack,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'chats'.tr,
              ),
              Tab(
                text: 'status'.tr,
              ),
              Tab(
                text: 'calls'.tr,
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            ContactsScreen(),
            Text(''),
            Text(''),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // if (tabBarController.index == 0) {
            //   Navigator.pushNamed(context, Routes.selectContactScreen);
            // } else if (tabBarController.index == 1) {
            //   bottomSheet(context, pickImageCamera, pickImageGallery);
            // } else if (tabBarController.index == 2) {
            //   Navigator.pushNamed(context, Routes.selectContactScreen);
            // }
          },
          backgroundColor: colorBlack,
          child: Icon(
            tabBarController.index == 0
                ? Icons.comment
                : tabBarController.index == 1
                    ? Icons.camera
                    : Icons.call,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

