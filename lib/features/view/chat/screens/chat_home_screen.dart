import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app/core/utils/dimensions.dart';

import '../../../../core/picker/picker.dart';
import '../../../../core/utils/app_colors.dart';
import '../../chat/widgets/contacts_list.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<ChatHomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       ref.read(authControllerProvider).setUserState(true);
  //       break;
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.detached:
  //     case AppLifecycleState.paused:
  //       ref.read(authControllerProvider).setUserState(false);
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.bgBlackColor,
          centerTitle: false,
          title: Text(
            "Chat",
            style: TextStyle(
              fontSize: Dimensions.font20,
              color: Colors.grey,
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
                  child: const Text(
                    'Create Group',
                  ),
                  onTap: () => Future(
                    (){},
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
            indicatorColor: AppColors.bgBlackColor,
            indicatorWeight: 4,
            labelColor: AppColors.bgBlackColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            ContactsList(),
            Text('chhc'),
            // StatusContactsScreen(),
            Text('Calls'),
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
          backgroundColor: AppColors.bgBlackColor,
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
