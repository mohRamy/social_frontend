import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_app/src/routes/app_pages.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';
import '../../../../../controller/app_controller.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/font_family.dart';

import '../../../../screens/auth/data/models/auth_model.dart';

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
              padding: EdgeInsets.symmetric(horizontal: Dimensions.size10),
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
              padding: EdgeInsets.symmetric(horizontal: Dimensions.size10),
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
            padding: EdgeInsets.all(Dimensions.size15),
            child: Text(
              'menu'.tr,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? mCL : colorBlack,
              ),
            ),
          ),
          InkWell(
            onTap: ()=> AppNavigator.push(AppRoutes.profile),
            child: Row(
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
                    Text(
                      userInfo.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Get.isDarkMode ? mCL : colorBlack,
                        )),
                    const SizedBox(height: 5.0),
                    AppText(
                      'see_your_profile'.tr,
                      type: TextType.small,
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(height: 20.0),
          ),
          customContainer(
            icon1: Icons.group,
            text1: 'groups'.tr,
            icon2: Icons.shopping_basket,
            text2: 'market_place'.tr,
          ),
          customContainer(
            icon1: Icons.person,
            text1: 'friends'.tr,
            icon2: Icons.history,
            text2: 'memories'.tr,
          ),
          customContainer(
            icon1: Icons.flag,
            text1: 'pages'.tr,
            icon2: Icons.save_alt,
            text2: 'saved'.tr,
          ),
          customContainer(
            icon1: FontAwesomeIcons.bagShopping,
            text1: 'jobs'.tr,
            icon2: Icons.event,
            text2: 'events'.tr,
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
                    AppText('help_support'.tr, type: TextType.medium),
                  ],
                ),
                const Icon(Icons.arrow_drop_down, size: 30.0),
              ],
            ),
          ),
          const Divider(),
          InkWell(
            onTap: (){
              AppNavigator.push(AppRoutes.setting);
            },
            child: Container(
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
                      AppText('setting_privacy'.tr, type: TextType.medium),
                    ],
                  ),
                  const Icon(Icons.arrow_drop_down, size: 30.0),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 65.0,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (AppGet.authGet.onAuthCheck()) {
                      AppGet.authGet.logout();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.exit_to_app,
                          size: 40.0, color: Colors.grey[700]),
                      const SizedBox(width: 10.0),
                      const AppText('Logout', type: TextType.medium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
