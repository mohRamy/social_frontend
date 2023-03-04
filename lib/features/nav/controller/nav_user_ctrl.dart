
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/presentation/screens/home_screen.dart';
import '../../post/presentation/screens/post_screen.dart';
import '../../profile/presentation/screens/profile_screen.dart';
import '../../search/presentation/screens/search_screen.dart';


class NavUserController extends GetxController {
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
