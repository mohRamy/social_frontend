import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/features/view/profile/profile_ctrl/profile_ctrl.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../data/models/user_model.dart';


class FollowingPage extends StatefulWidget {

  const FollowingPage({Key? key}) : super(key: key);

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Following', letterSpacing: .8, fontSize: 19),
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.pop(context), 
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,)
          ),
        ),
        body: const SafeArea(
          // child: FutureBuilder<List<Following>>(
          //   future: userService.getAllFollowing(),
          //   builder: (context, snapshot) {
          //     return !snapshot.hasData
          //     ? Column(
          //         children: const [
          //           ShimmerFrave(),
          //           SizedBox(height: 10.0),
          //           ShimmerFrave(),
          //           SizedBox(height: 10.0),
          //           ShimmerFrave(),
          //         ],
          //       )
          //     : 
        
          child: _ListFollowings(),
            
          
        ),
      
    );
  }
}

class _ListFollowings extends StatelessWidget {


  const _ListFollowings({ Key? key,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserModel> usersData = Get.arguments;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: usersData.length,
      itemBuilder: (context, i){
          UserModel userData = usersData[i];
        return InkWell(
          borderRadius: BorderRadius.circular(10.0),
          splashColor: Colors.grey[300],
          onTap: () => Get.toNamed(Routes.PROFILE, arguments: userData.id),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0)
            ),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(userData.photo),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCustom(text: userData.name, fontSize: 16 ),
                        TextCustom(text: userData.email, color: Colors.grey, fontSize: 15 )
                      ],
                    ),
                  ],
                ),
                GetBuilder<ProfileCtrl>(
                  builder: (profileCtrl) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(50.0)),
                      elevation: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        splashColor: Colors.blue[50],
                        onTap: () => profileCtrl.deleteFollowing(userData.id),
                        child: const Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 17.0, vertical: 6.0),
                          child: TextCustom(text: 'Siguiendo', fontSize: 16),
                        )
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}





