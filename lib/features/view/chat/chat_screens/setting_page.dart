import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../json/chat_json.dart';
import '../json/setting_json.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.bgColor,
      leading: IconButton(
        onPressed: null,
        icon: Icon(
          Icons.qr_code,
          color: AppColors.primary,
          size: 28,
        ),
      ),
      actions: [
        IconButton(
          onPressed: null,
          icon: Text(
            "Edit",
            style: TextStyle(
                fontSize: 16,
                color: AppColors.primary,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(profile[0]['img']),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            profile[0]['name'],
            style: TextStyle(
                fontSize: 24,
                color: AppColors.white,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "+855 10 101 101 - @sopheamen",
            style: TextStyle(
                fontSize: 18,
                color: AppColors.white.withOpacity(0.5),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30,
          ),
          getSectionOne(),
          SizedBox(
            height: 30,
          ),
          getSectionTwo(),
          SizedBox(
            height: 30,
          ),
          getSectionThree(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget getSectionOne() {
    return Column(
      children: List.generate(setting_section_one.length, (index) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.textfieldColor),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: setting_section_one[index]['color'],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Icon(
                              setting_section_one[index]['icon'],
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          setting_section_one[index]['text'],
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.white.withOpacity(0.2),
                      size: 15,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget getSectionTwo() {
    return Column(
      children: List.generate(setting_section_two.length, (index) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.textfieldColor),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: setting_section_two[index]['color'],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Icon(
                              setting_section_two[index]['icon'],
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          setting_section_two[index]['text'],
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        getLangAndSticker(setting_section_two[index]['text']),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white.withOpacity(0.2),
                          size: 15,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  getLangAndSticker(value) {
    if (value == "Language") {
      return Text(
        "English",
        style: TextStyle(fontSize: 15, color: AppColors.white.withOpacity(0.5)),
      );
    } else if (value == "Stickers and Emoji") {
      return Badge(
        badgeColor: AppColors.primary,
        badgeContent: Text(
          "12",
          style: TextStyle(fontSize: 15, color: AppColors.white),
        ),
      );
    }
    return Container();
  }

  Widget getSectionThree() {
    return Column(
      children: List.generate(setting_section_three.length, (index) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.textfieldColor),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: setting_section_three[index]['color'],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Icon(
                              setting_section_three[index]['icon'],
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          setting_section_three[index]['text'],
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.white.withOpacity(0.2),
                      size: 15,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
