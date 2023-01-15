import 'package:flutter/material.dart';
import 'package:social_app/core/utils/dimensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../data/models/user_model.dart';
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat; // select contact عند الخطأ زوده في
  final String profilePic;
  const ChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    this.profilePic = AppString.ASSETS_APPLIANCES,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgBlackColor,
        automaticallyImplyLeading: false,
        title: StreamBuilder<UserModel>(
            // stream: ref.read(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return Row(
                children: [
                  InkWell(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                            ),
                            CircleAvatar(
                              radius: Dimensions.radius20,
                              backgroundImage: NetworkImage(profilePic),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(width: Dimensions.width10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      // !isGroupChat
                      //     ? snapshot.data!.isOnline
                      //         ? 
                              // Text(
                              //     'online',
                              //     style: TextStyle(
                              //       fontSize: Dimensions.font16 - 3,
                              //       fontWeight: FontWeight.normal,
                              //     ),
                              //   )
                              // : Container()
                          // : Container(),
                    ],
                  ),
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            AppString.APP_NAME,
            height: Dimensions.screenHeight,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Expanded(
                child: ChatList(
                  recieverUserId: uid,
                  isGroupChat: isGroupChat,
                ),
              ),
              BottomChatField(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Row iconChat({
//   required IconData icon,
//   required double width,
// }) {
//   return Row(
//     children: [
//       InkWell(
//         borderRadius: BorderRadius.circular(50),
//         onTap: () {},
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             icon,
//           ),
//         ),
//       ),
//       SizedBox(
//         width: width,
//       ),
//     ],
//   );
// }

// appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             InkWell(
//               borderRadius: BorderRadius.circular(50),
//               onTap: () => Navigator.pop(context),
//               child: Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.arrow_back),
//                     CircleAvatar(
//                       radius: 18,
//                       backgroundImage: NetworkImage(profilePic),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             StreamBuilder(
//               stream: ref.read(authControllerProvider).userDataById(uid),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return  Container();
//                 }
//                 return Column(
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 18,
//                   ),
//                 ),
//                 snapshot.data!.isOnline ?
//                 const Text(
//                   'online',
//                 style: TextStyle(
//                     color: Colors.white70,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 13,
//                   ),):
//                 Container(),
//               ],
//             );
//               },
//             ),
//           ],
//         ),
//         actions: [
//           iconChat(icon: Icons.video_call, width: 8),
//           iconChat(icon: Icons.call, width: 8),
//           iconChat(icon: Icons.more_vert, width: 5),
//         ],
//       ),
