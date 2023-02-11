import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/dimensions.dart';
import 'package:social_app/features/view/chat/screens/chat_screen.dart';
import 'package:social_app/features/view/home/home_widgets/profile_avatar.dart';

import '../../../data/models/user_model.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserModel> usersData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.chatBoxMe,
        elevation: 0.0,
        title: const Text('Chats'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Dimensions.height10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: snapshot.data?.length??0,
              //   itemBuilder: (context, index) {
              //     var groupData = snapshot.data![index];

              //     return Column(
              //       children: [
              //         InkWell(
              //           onTap: () {
              //       //       Components.navigateTo(
              //       //   context,
              //       //   Routes.chatScreen,
              //       //   {
              //       //     AppString.argumentName: groupData.name,
              //       //     AppString.argumentUid: groupData.groupId,
              //       //     AppString.argumentisGroupChat : false,
              //       //     AppString.argumentImage: groupData.groupPic,
              //       //   },
              //       // );
              //           },
              //           child: Padding(
              //             padding:  EdgeInsets.only(bottom: Dimensions.height10 - 2),
              //             child: ListTile(
              //               title: Text(
              //                 groupData.name,
              //                 style:  TextStyle(
              //                   fontSize: Dimensions.font16 + 2,
              //                 ),
              //               ),
              //               subtitle: Padding(
              //                 padding:  EdgeInsets.only(top: Dimensions.height10 - 4),
              //                 child: Text(
              //                   groupData.lastMessage,
              //                   style:  TextStyle(fontSize: Dimensions.font16 - 1),
              //                 ),
              //               ),
              //               leading: CircleAvatar(
              //                 backgroundImage: NetworkImage(
              //                   groupData.groupPic,

              //                 ),
              //                 radius: Dimensions.radius30,
              //               ) ,
              //               trailing: Text(
              //                 DateFormat.jm().format(groupData.timeSent),
              //                 style: TextStyle(
              //                   color: Colors.grey,
              //                   fontSize: Dimensions.font16 - 3,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ),

              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: usersData.length,
                itemBuilder: (context, i) {
                  UserModel userData = usersData[i];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ChatScreen(
                            name: userData.name,
                            uid: userData.id,
                            isGroupChat: false,
                            photo: userData.photo,
                          ));
                          // Components.navigateTo(
                          //   context,
                          //   Routes.chatScreen,
                          //   {
                          //     AppString.argumentName: chatContactData.name,
                          //     AppString.argumentUid:
                          //         chatContactData.contactId,
                          //     AppString.argumentisGroupChat: false,
                          //     AppString.argumentImage:
                          //         chatContactData.profilePic,
                          //   },
                          // );
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: Dimensions.height10 - 2),
                          child: ListTile(
                            title: Text(
                              userData.name,
                              style: TextStyle(
                                fontSize: Dimensions.font16 + 2,
                              ),
                            ),
                            subtitle: Padding(
                              padding:
                                  EdgeInsets.only(top: Dimensions.height10 - 4),
                              child: Text(
                                userData.email,
                                style:
                                    TextStyle(fontSize: Dimensions.font16 - 1),
                              ),
                            ),
                            leading: ProfileAvatar(
                              imageUrl: userData.photo,
                              sizeImage: 50,
                            ),
                            // trailing: Text(
                            //   DateFormat.jm()
                            //       .format(chatContactData.timeSent),
                            //   style: TextStyle(
                            //     color: Colors.grey,
                            //     fontSize: Dimensions.font16 - 3,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
