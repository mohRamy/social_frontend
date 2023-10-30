import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/models/chat_model.dart';
import '../controller/chat_controller.dart';
import '../../../../routes/app_pages.dart';

import '../../../../utils/sizer_custom/sizer.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../home/presentation/components/profile_avatar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: Dimensions.size10),
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

              GetBuilder<ChatController>(
                builder: (chatCtrl) {
                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: chatCtrl.contentList.length,
                    itemBuilder: (context, i) {
                      Auth userData = chatCtrl.contentList[i].recieverData;
                      MessageModel lastMessage = chatCtrl.contentList[i].lastMessage;
                      DateTime createdAt = chatCtrl.contentList[i].createdAt;
                      
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              AppNavigator.push(
                                AppRoutes.chat,
                                arguments: {
                                  'content': chatCtrl.contentList[i],
                                  'isGroupChat': false,
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.sp),
                              child: ListTile(
                                title: Text(
                                  userData.name,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                subtitle: Text(
                                  lastMessage.msg.message,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                leading: ProfileAvatar(
                                  imageUrl: userData.photo,
                                  sizeImage: 50,
                                ),
                                trailing: Text(
                                  DateFormat.jm().format(createdAt),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimensions.size15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              )
            ],
          ),
        ),
    );
  }
}
