import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/dimensions.dart';
import 'package:social_app/features/data/models/chat_contact_model.dart';
import 'package:social_app/features/data/models/group.dart';

import '../../../../core/utils/app_strings.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.height10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<GroupModel>>(
                // stream: ref.watch(chatControllerProvider).chatGroups(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (context, index) {
                      var groupData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                        //       Components.navigateTo(
                        //   context,
                        //   Routes.chatScreen,
                        //   {
                        //     AppString.argumentName: groupData.name,
                        //     AppString.argumentUid: groupData.groupId,
                        //     AppString.argumentisGroupChat : false,
                        //     AppString.argumentImage: groupData.groupPic,
                        //   },
                        // );
                            },
                            child: Padding(
                              padding:  EdgeInsets.only(bottom: Dimensions.height10 - 2),
                              child: ListTile(
                                title: Text(
                                  groupData.name,
                                  style:  TextStyle(
                                    fontSize: Dimensions.font16 + 2,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:  EdgeInsets.only(top: Dimensions.height10 - 4),
                                  child: Text(
                                    groupData.lastMessage,
                                    style:  TextStyle(fontSize: Dimensions.font16 - 1),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    groupData.groupPic,
                                    
                                  ),
                                  radius: Dimensions.radius30,
                                ) ,
                                trailing: Text(
                                  DateFormat.jm().format(groupData.timeSent),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimensions.font16 - 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
            StreamBuilder<List<ChatContactModel>>(
                // stream: ref.watch(chatControllerProvider).chatContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Container();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (context, index) {
                      var chatContactData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
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
                              padding: EdgeInsets.only(bottom: Dimensions.height10 - 2),
                              child: ListTile(
                                title: Text(
                                  chatContactData.name,
                                  style: TextStyle(
                                    fontSize: Dimensions.font16 + 2,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: Dimensions.height10 - 4),
                                  child: Text(
                                    chatContactData.lastMessage,
                                    style: TextStyle(fontSize: Dimensions.font16 - 1),
                                  ),
                                ),
                                leading: chatContactData.profilePic.isNotEmpty ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    chatContactData.profilePic,
                                  ),
                                  radius: Dimensions.radius30,
                                ) :  CircleAvatar(
                                  backgroundImage: const AssetImage(
                                    AppString.ASSETS_APPLIANCES,
                                  ),
                                  radius: Dimensions.radius30,
                                ),
                                trailing: Text(
                                  DateFormat.jm()
                                      .format(chatContactData.timeSent),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimensions.font16 - 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //const Divider(color: dividerColor, indent: 85),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
