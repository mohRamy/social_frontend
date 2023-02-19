import 'dart:convert';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/network_info.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/models/group.dart';

import '../../../../core/utils/app_component.dart';
import '../../../../core/utils/constants/state_handle.dart';
import '../repo/chat_repo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatCtrl extends GetxController {
  final ChatRepo chatRepo;
  final NetworkInfo networkInfo;
  ChatCtrl( {
    required this.chatRepo,
    required this.networkInfo,
  });

  

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ChatModel chatContacts = ChatModel();
  List<GroupModel> groups = [];
  // List<MsgModel> messages = [];
  // List<MsgModel> groupMessages = [];

  

  // void emitSocket(
  //   Msg msg,
  //   RepliedMsg? repliedMsg,
  //   String recieverUserId,
  //   bool isGroupChat,
  // )async{
  //   if (msg.type == 'image' || msg.type == 'video') {
  //     int random = Random().nextInt(1000);
  //     final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
  //     CloudinaryResponse res = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(
  //         msg.message!,
  //         folder: "$random",
  //       ),
  //     );
  //     msg.message = res.secureUrl;
  //   }

  //   if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
  //     int random = Random().nextInt(1000);

  //     final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

  //     CloudinaryResponse res = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(
  //         repliedMsg.repliedMessage!,
  //         folder: "$random",
  //       ),
  //     );
  //     repliedMsg.repliedMessage = res.secureUrl;
  //   }
  //   _socket.emit(
  //     "message",
  //     jsonEncode({
  //       'recieverId': recieverUserId,
  //       'message': msg.message,
  //       'type': msg.type,
  //       'repliedMessage': repliedMsg.repliedMessage,
  //       'repliedType': repliedMsg.type,
  //       'repliedTo': repliedMsg.repliedTo,
  //       'repliedIsMe': repliedMsg.isMe,
  //     }),
  //   );
  // }

  

  Future<void> fetchAllChatContact() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await chatRepo.fetchAllChatContact();
        stateHandle(
          res: res,
          onSuccess: () {
            chatContacts = ChatModel.fromJson(jsonDecode(res.body));
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        // Components.showCustomSnackBar(e.toString());pp
      }
    } else {
      try {
        _isLoading = true;
        update();
        // contacts = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        // Components.showCustomSnackBar(e.toString());
      }
    }
  }

  Future<void> fetchAllChatGroups() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await chatRepo.fetchAllChatGroups();
        stateHandle(
          res: res,
          onSuccess: () {
            groups = [];
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              groups.add(
                GroupModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            // storyLocalSource.addToStoryList(stories);
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        AppComponent.showCustomSnackBar(e.toString());
      }
    } else {
      try {
        _isLoading = true;
        update();
        // contacts = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        AppComponent.showCustomSnackBar(e.toString());
      }
    }
  }

  // Future<void> fetchChat(String userId) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       _isLoading = true;
  //       update();
  //       http.Response res = await chatRepo.fetchChat(userId);
  //       stateHandle(
  //         res: res,
  //         onSuccess: () {
  //           messages = [];
  //           for (var i = 0; i < jsonDecode(res.body).length; i++) {
  //             messages.add(
  //               MsgModel.fromMap(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             );
  //           }
  //           // storyLocalSource.addToStoryList(stories);
  //         },
  //       );
  //       _isLoading = false;
  //       update();
  //     } catch (e) {
  //       Components.showCustomSnackBar(e.toString());
  //     }
  //   } else {
  //     try {
  //       _isLoading = true;
  //       update();
  //       // contacts = await storyLocalSource.getStoryList();
  //       _isLoading = false;
  //       update();
  //     } catch (e) {
  //       Components.showCustomSnackBar(e.toString());
  //     }
  //   }
  // }

  // Future<void> fetchGroupChat(String groupId) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       _isLoading = true;
  //       update();
  //       http.Response res = await chatRepo.fetchGroupChat(groupId);
  //       stateHandle(
  //         res: res,
  //         onSuccess: () {
  //           groupMessages = [];
  //           for (var i = 0; i < jsonDecode(res.body).length; i++) {
  //             groupMessages.add(
  //               MsgModel.fromMap(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             );
  //           }
  //           // storyLocalSource.addToStoryList(stories);
  //         },
  //       );
  //       _isLoading = false;
  //       update();
  //     } catch (e) {
  //       Components.showCustomSnackBar(e.toString());
  //     }
  //   } else {
  //     try {
  //       _isLoading = true;
  //       update();
  //       // contacts = await storyLocalSource.getStoryList();
  //       _isLoading = false;
  //       update();
  //     } catch (e) {
  //       Components.showCustomSnackBar(e.toString());
  //     }
  //   }
  // }

  // void sendMsg(
  //   Msg msg,
  //   RepliedMsg? repliedMsg,
  //   String recieverId,
  //   bool isGroupChat,
  // ) async {
  //   // http.Response res = await chatRepo.sendMsg(
  //   //   msg: msg,
  //   //   repliedMsg: repliedMsg,
  //   //   recieverId: recieverUserId,
  //   //   senderUser: Get.find<UserCtrl>().user,
  //   //   isGroupChat: isGroupChat,
  //   // );
  //   if (msg.type == 'image' || msg.type == 'video') {
  //     int random = Random().nextInt(1000);
  //     final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
  //     CloudinaryResponse res = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(
  //         msg.message!,
  //         folder: "$random",
  //       ),
  //     );
  //     msg.message = res.secureUrl;
  //   }

  //   if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
  //     int random = Random().nextInt(1000);

  //     final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

  //     CloudinaryResponse res = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(
  //         repliedMsg.repliedMessage!,
  //         folder: "$random",
  //       ),
  //     );
  //     repliedMsg.repliedMessage = res.secureUrl;
  //   }

  //   // if (isGroupChat) {
  //   //   await apiClient.postData(
  //   //     AppString.SIGN_IN_URL,
  //   //     jsonEncode({
  //   //       'message': message.toMap(),
  //   //     }),
  //   //   );
  //   // } else {
      
  //     _socket.emit('message', {
  //       'senderId': chatContacts.userId,
  //       'recieverId': recieverId,
  //       'message': msg.message,
  //       'type': msg.type,
  //       'repliedMessage': repliedMsg.repliedMessage,
  //       'repliedType': repliedMsg.type,
  //       'repliedTo': repliedMsg.repliedTo,
  //       'repliedIsMe': repliedMsg.isMe,
  //     });
    
  // }
    
    void setChatMessageSeen(
    String recieverId,
    // String messageId,
  ) async {
    try {
      http.Response res = await chatRepo.setChatMessageSeen(
      recieverId,
      // messageId,
    );
    stateHandle(
      res: res, 
      onSuccess: (){
      AppComponent.showCustomSnackBar('Seen True');
    });
    } catch (e) {
      AppComponent.showCustomSnackBar(e.toString());
    }
  }
  }

  

