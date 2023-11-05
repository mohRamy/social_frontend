import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/app_controller.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../themes/app_colors.dart';
import '../components/item_profile.dart';
import '../controller/profile_controller.dart';

class PrivacyProfilePage extends StatefulWidget {

  const PrivacyProfilePage({Key? key}) : super(key: key);

  @override
  State<PrivacyProfilePage> createState() => _PrivacyProfilePageState();
}

class _PrivacyProfilePageState extends State<PrivacyProfilePage> {
  bool private = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const TextCustom(text: 'Privacy', fontSize: 19, fontWeight: FontWeight.w500 ),
          elevation: 0,
        ),
        body: SafeArea(
          child: GetBuilder<ProfileController>(
            builder: (profileCtrl) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  const TextCustom(text: 'account privacy', fontSize: 16, fontWeight: FontWeight.w500),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: InkWell(
                      onTap: (){
                        profileCtrl.privateAccount();
                        setState(() {
                          private = !private;
                        });
                      },
                      child:  Row(
                          children: [
                            const Icon(Icons.lock_outlined),
                            const SizedBox(width: 10),
                            const TextCustom(text: 'private account', fontSize: 17 ),
                            const Spacer(),
                            (AppGet.authGet.userData!.private || private)
                              ? Icon(Icons.radio_button_checked_rounded, color: colorPrimary)
                              : const Icon(Icons.radio_button_unchecked_rounded),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      
                    ),
                  
    
                  const Divider(),
                  const SizedBox(height: 10.0),
                  const TextCustom(text: 'Interactions', fontSize: 16, fontWeight: FontWeight.w500),
                  const SizedBox(height: 10.0),
                  ItemProfile(
                    text: 'Comments', 
                    icon: Icons.chat_bubble_outline_rounded, 
                    onPressed: (){}
                  ),
                  ItemProfile(
                    text: 'Post', 
                    icon: Icons.add_box_outlined, 
                    onPressed: (){}
                  ),
                  ItemProfile(
                    text: 'Mentions', 
                    icon: Icons.alternate_email_sharp, 
                    onPressed: (){}
                  ),
                  ItemProfile(
                    text: 'Stories', 
                    icon: Icons.control_point_duplicate_rounded, 
                    onPressed: (){}
                  ),
                  ItemProfile(
                    text: 'Messages', 
                    icon: Icons.send_rounded, 
                    onPressed: (){}
                  ),
                  const Divider(),
                  const SizedBox(height: 10.0),
                  const TextCustom(text: 'Connections', fontSize: 16, fontWeight: FontWeight.w500),
                  const SizedBox(height: 10.0),
                  ItemProfile(
                    text: 'restrict accounts', 
                    icon: Icons.no_accounts_outlined, 
                    onPressed: (){}
                  ),
                  ItemProfile(
                    text: 'block accounts', 
                    icon: Icons.highlight_off_rounded, 
                    onPressed: (){}
                  ),
                  ItemProfile(
                    text: 'mute accounts', 
                    icon: Icons.notifications_off_outlined, 
                    onPressed: (){}
                  ),
                  ItemProfile(
                    text: 'accounts you follow', 
                    icon: Icons.people_alt_outlined, 
                    onPressed: (){}
                  ),
                ],
              );
            }
          ),
        ),
    );
  }
}