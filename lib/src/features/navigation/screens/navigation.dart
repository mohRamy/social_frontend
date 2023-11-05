
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../friend/presentation/screens/friends_tab.dart';
import '../../home/presentation/screens/home_tab.dart';
import '../../menu/presentation/screens/menu_tab.dart';
import '../../notification/presentation/screens/notifications_tab.dart';
import '../../profile/presentation/screens/profile_tab.dart';
import '../../watch/presentation/screens/watch_tab.dart';


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

class _NavigationState extends State<Navigation> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('roomBook', style: TextStyle(color: Colors.blueAccent, fontSize: 27.0, fontWeight: FontWeight.bold)),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.search, color: Colors.black),

                SizedBox(width: 15.0),

                Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black)
              ]
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          tabs: const [
            Tab(icon: Icon(Icons.home, size: 30.0)),
            Tab(icon: Icon(Icons.people, size: 30.0)),
            Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
            Tab(icon: Icon(Icons.account_circle, size: 30.0)),
            Tab(icon: Icon(Icons.notifications, size: 30.0)),
            Tab(icon: Icon(Icons.menu, size: 30.0))
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeTab(),
          FriendsTab(),
          WatchTab(),
          ProfileTab(),
          NotificationsTab(),
          MenuTab()
        ]
      ),
    );
  }
}