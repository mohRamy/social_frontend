
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';

import '../controller/navigation_controller.dart';


class Navigation extends GetView<NavigationController> {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () =>  BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: controller.item.map(
            (lable, icon)=> MapEntry(
            lable, 
            BottomNavigationBarItem(
              icon: Icon(icon),
              label: lable,
              ),
            )).values.toList(),
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changePage(index);
          },
          selectedItemColor: colorPrimary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          ),
      ),
        body: Obx(()=>controller.pages[controller.currentIndex.value],),
    );
  }
}