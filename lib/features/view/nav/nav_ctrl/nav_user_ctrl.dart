
import '../../post/post_screen/post_screen.dart';
import '../../profile/profile_screen/profile_screen.dart';
import '../../search/search_screens/search_screen.dart';

import '../../home/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NavUserCtrl extends GetxController {
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
    'cart': Icons.favorite_border_rounded,
    'me': Icons.person,
  };
  Map<String, IconData> get item => _items;

  final Rx<int> _currentIndex = 0.obs;
  Rx<int> get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex.value = index;
  }
}
