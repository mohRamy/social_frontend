
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/app_controller.dart';
import '../../../services/socket/socket.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../post/presentation/screens/post_screen.dart';
import '../../profile/presentation/screens/profile_screen.dart';
import '../../search/presentation/screens/search_screen.dart';


class NavigationController extends GetxController {
  
  @override
  void onInit() {
    if (AppGet.authGet.onAuthCheck()) {
      AppGet.authGet.getUserInfo();
      AppGet.chatGet.getUserChat();
      connectAndListen();
    }
    super.onInit();
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const Scaffold(),
    const ProfileScreen(),
  ];
  List<Widget> get pages => _pages;

  final Map<String, IconData> _items = {
    'home': Icons.home_outlined,
    'search': Icons.search,
    'history': Icons.add,
    'cart': Icons.notifications_active,
    'me': Icons.person,
  };
  Map<String, IconData> get item => _items;

  final Rx<int> _currentIndex = 0.obs;
  Rx<int> get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex.value = index;
  }

}
