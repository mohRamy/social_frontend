import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../../taps/home/presentation/components/profile_avatar.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../data/models/chat_model.dart';

import '../controllers/chat_controller.dart';

class ContactsScreen extends GetView<ChatController> {
  const ContactsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ChatController chatController = AppGet.chatGet;
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
                itemCount: chatCtrl.contacts.length,
                itemBuilder: (context, i) {
                  AuthModel userData = chatCtrl.contacts[i].recieverData;
                  MessageModel lastMessage =
                      chatCtrl.contacts[i].lastMessage;
                  DateTime createdAt =
                      chatCtrl.contacts[i].lastMessage.createdAt;
                  List<MessageModel> messages =
                      chatCtrl.contacts[i].messages;
                  int messagesNotSeen = 0;
                  for (var element in messages) {
                    if (element.senderId != UserLocal().getUserId() &&
                        !element.isSeen) {
                      messagesNotSeen += 1;
                    }
                  }
                  String typeIcon() {
                    String contactMsg;
                    switch (lastMessage.msg.type) {
                      case "image":
                        contactMsg = '📷 Photo';
                        break;
                      case "video":
                        contactMsg = '📸 Video';
                        break;
                      case "audio":
                        contactMsg = '🎵 Audio';
                        break;
                      case "gif":
                        contactMsg = 'GIF';
                        break;
                      default:
                        contactMsg = lastMessage.msg.message;
                    }
                    return contactMsg;
                  }

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          AppNavigator.push(
                            AppRoutes.chat,
                            arguments: {
                              'user-data': userData,
                              'is-group-chat': false,
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
                              subtitle: lastMessage.senderId ==
                                      UserLocal().getUserId()
                                  ? Row(
                                      children: [
                                        Text(
                                          typeIcon(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(width: 5),
                                        CircleAvatar(
                                          radius: 9,
                                          backgroundColor: lastMessage.isSeen
                                              ? colorPrimary
                                              : mCL,
                                          child: Icon(
                                            Icons.done,
                                            size: Dimensions.size10,
                                            color: lastMessage.isSeen
                                                ? mCL
                                                : colorPrimary,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      width: 150,
                                      child: Text(
                                        typeIcon(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                              // subtitle: lastMessage.msg.type == 'text'
                              //     ? Text(
                              //         lastMessage.msg.message,
                              //         style: TextStyle(
                              //           fontSize: 14.sp,
                              //         ),
                              //       )
                              //     : lastMessage.msg.type == 'image'
                              //         ? Tex('image')
                              //         : Text(''),
                              leading: ProfileAvatar(
                                imageUrl: userData.photo,
                                sizeImage: 50,
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat.jm().format(createdAt),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: Dimensions.size10,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.size5),
                                  messagesNotSeen != 0
                                      ? CircleAvatar(
                                          radius: 12,
                                          backgroundColor: colorPrimary,
                                          child: Text(
                                            messagesNotSeen.toString(),
                                            style: TextStyle(
                                              color: colorBlack,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              )),
                        ),
                      ),
                    ],
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
