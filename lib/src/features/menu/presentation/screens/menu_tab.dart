import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_app/src/controller/app_controller.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';
import 'package:social_app/src/themes/app_colors.dart';
import 'package:social_app/src/themes/font_family.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel userInfo = AppGet.authGet.userData!;

    Text customText(String text) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? mCL : colorBlack,
          fontFamily: FontFamily.lato,
        ),
      );
    }

    Container customContainer({
      required IconData icon1,
      required String text1,
      required IconData icon2,
      required String text2,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 85.0,
              padding: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(icon1, color: Colors.blue, size: 30.0),
                  const SizedBox(height: 5.0),
                  customText(text1),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 30,
              height: 85.0,
              padding: const EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(icon2, color: Colors.blue, size: 30.0),
                  const SizedBox(height: 5.0),
                  customText(text2),
                ],
              ),
            )
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: SizedBox(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? mCL : colorBlack,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              const SizedBox(width: 15.0),
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(userInfo.photo),
              ),
              const SizedBox(width: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(userInfo.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Get.isDarkMode ? mCL : colorBlack,
                      )),
                  const SizedBox(height: 5.0),
                  const Text(
                    'See your profile',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(height: 20.0),
          ),
          customContainer(
            icon1: Icons.group,
            text1: 'Groups',
            icon2: Icons.shopping_basket,
            text2: 'Marketplace',
          ),
          customContainer(
            icon1: Icons.person,
            text1: 'Friends',
            icon2: Icons.history,
            text2: 'Memories',
          ),
          customContainer(
            icon1: Icons.flag,
            text1: 'Pages',
            icon2: Icons.save_alt,
            text2: 'Saved',
          ),
          customContainer(
            icon1: FontAwesomeIcons.bagShopping,
            text1: 'Jobs',
            icon2: Icons.event,
            text2: 'Events',
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65.0,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.help, size: 40.0, color: Colors.grey[700]),
                    const SizedBox(width: 10.0),
                    const AppText('Help & Support', type: TextType.medium),
                  ],
                ),
                const Icon(Icons.arrow_drop_down, size: 30.0),
              ],
            ),
          ),
          const Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65.0,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.settings, size: 40.0, color: Colors.grey[700]),
                    const SizedBox(width: 10.0),
                    const AppText('Settings & Privacy', type: TextType.medium),
                  ],
                ),
                const Icon(Icons.arrow_drop_down, size: 30.0),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65.0,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.exit_to_app,
                        size: 40.0, color: Colors.grey[700]),
                    const SizedBox(width: 10.0),
                    const AppText('Logout', type: TextType.medium),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
