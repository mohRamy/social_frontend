import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../../../core/widgets/item_setting.dart';
import '../controllers/privacy_controller.dart';

class PrivacyScreen extends GetView<PrivacyController> {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const AppText('Privacy'),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.size15,
              vertical: Dimensions.size10,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              const AppText(
                'account privacy',
                type: TextType.medium,
              ),
              SizedBox(height: Dimensions.size10),
              GetBuilder<PrivacyController>(
                builder: (privacyCtrl) {
                  return SizedBox(
                    height: 50.sp,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        privacyCtrl.privateAccount();
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.lock_outlined),
                          SizedBox(width: Dimensions.size10),
                          TextCustom(
                              text: 'private account', fontSize: Dimensions.size15),
                          const Spacer(),
                          privacyCtrl.isPrivate
                              ? Icon(
                                  Icons.radio_button_checked_rounded,
                                  color: colorPrimary,
                                )
                              : const Icon(Icons.radio_button_unchecked_rounded),
                          SizedBox(
                            width: Dimensions.size10,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
              const Divider(),
              SizedBox(height: Dimensions.size10),
              const AppText('Interactions'),
              SizedBox(height: Dimensions.size10),
              ItemSetting(
                  text: 'Comments',
                  icon: Icons.chat_bubble_outline_rounded,
                  onPressed: () {}),
              ItemSetting(
                  text: 'Post', icon: Icons.add_box_outlined, onPressed: () {}),
              ItemSetting(
                  text: 'Mentions',
                  icon: Icons.alternate_email_sharp,
                  onPressed: () {}),
              ItemSetting(
                  text: 'Stories',
                  icon: Icons.control_point_duplicate_rounded,
                  onPressed: () {}),
              ItemSetting(
                  text: 'Messages', icon: Icons.send_rounded, onPressed: () {}),
              const Divider(),
              SizedBox(height: Dimensions.size10),
              const TextCustom(
                  text: 'Connections',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              SizedBox(height: Dimensions.size10),
              ItemSetting(
                  text: 'restrict accounts',
                  icon: Icons.no_accounts_outlined,
                  onPressed: () {}),
              ItemSetting(
                  text: 'block accounts',
                  icon: Icons.highlight_off_rounded,
                  onPressed: () {}),
              ItemSetting(
                  text: 'mute accounts',
                  icon: Icons.notifications_off_outlined,
                  onPressed: () {}),
              ItemSetting(
                  text: 'accounts you follow',
                  icon: Icons.people_alt_outlined,
                  onPressed: () {}),
            ],
          ),
      ),
    );
  }
}
