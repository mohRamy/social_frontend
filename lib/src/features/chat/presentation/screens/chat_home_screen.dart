import 'dart:io';

import 'package:flutter/material.dart';

import 'package:social_app/src/themes/app_colors.dart';

import '../../../../core/picker/picker.dart';
import '../../../../utils/sizer_custom/sizer.dart';
import '../../../auth/domain/entities/auth.dart';
import '../components/contacts_list.dart';

class ChatHomeScreen extends StatefulWidget {
  final List<Auth> usersData; 
  const ChatHomeScreen({
    Key? key,
    required this.usersData,
  }) : super(key: key);

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
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Text(
            "Chat",
            style: TextStyle(
              fontSize: Dimensions.size20,
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
            indicatorColor: colorBlack,
            indicatorWeight: 4,
            labelColor: colorBlack,
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
          children: [
            ContactsScreen(usersData: widget.usersData),
            const Text('chhc'),
            const Text('Calls'),
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
