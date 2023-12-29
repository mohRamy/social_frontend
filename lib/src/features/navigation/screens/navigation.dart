import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../taps/notification/presentation/controllers/notifications_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';

import '../../../controller/app_controller.dart';
import '../../../services/socket/socket.dart';
import '../../taps/requist/presentation/screens/requist_tab.dart';
import '../../taps/home/presentation/screens/home_tab.dart';
import '../../taps/menu/presentation/screens/menu_tab.dart';
import '../../taps/notification/presentation/screens/notifications_tab.dart';
import '../../taps/watch/presentation/screens/watch_tab.dart';

// class Navigation extends GetView<NavigationController> {
//   const Navigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () =>  BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           items: controller.item.map(
//             (lable, icon)=> MapEntry(
//             lable,
//             BottomNavigationBarItem(
//               icon: Icon(icon),
//               label: lable,
//               ),
//             )).values.toList(),
//           currentIndex: controller.currentIndex.value,
//           onTap: (index) {
//             controller.changePage(index);
//           },
//           selectedItemColor: colorPrimary,
//           unselectedItemColor: Colors.grey,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           ),
//       ),
//         body: Obx(()=>controller.pages[controller.currentIndex.value],),
//     );
//   }
// }

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  final NotificationController notificationCtrl = AppGet.notificationGet;

  @override
  void initState() {
    super.initState();
    if (AppGet.authGet.onAuthCheck()) {
      // AppGet.notificationGet.getNotofications();
      // getFirebaseMessagingToken().then((value) => AppGet.authGet.addUserFcmToken(value??""));
      AppGet.authGet.getUserInfo();
      AppGet.chatGet.getUserChat();
      connectAndListen();
    }
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        AppGet.authGet.isUserOnline(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        AppGet.authGet.isUserOnline(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('roomBook',
                    style: TextStyle(
                        color: colorPrimary,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              GestureDetector(
                  onTap: () {
                    AppNavigator.push(AppRoutes.search);
                  },
                  child: const Icon(Icons.search)),
              const SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                  AppNavigator.push(AppRoutes.chatHome);
                },
                child: const Icon(
                  FontAwesomeIcons.facebookMessenger,
                ),
              ),
            ]),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          tabs: [
            const Tab(icon: Icon(Icons.home, size: 30.0)),
            const Tab(icon: Icon(Icons.people, size: 30.0)),
            const Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
            // const Tab(icon: Icon(Icons.account_circle, size: 30.0)),
            Tab(
              icon: Obx(
                ()=> Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      const Icon(Icons.notifications, size: 30.0),
                      notificationCtrl.notificationNotSeen.value != 0
                          ? Positioned(
                              top: 2.0,
                              right: 2.0,
                              child: Text(
                                notificationCtrl.notificationNotSeen.value.toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
              ),
            ),
            const Tab(icon: Icon(Icons.menu, size: 30.0))
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeTab(),
          RequistTab(),
          WatchTab(videoUrl: ''),
          NotificationsTab(),
          MenuTab(),
        ],
      ),
    );
  }
}
