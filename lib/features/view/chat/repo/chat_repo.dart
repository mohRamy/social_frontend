import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/user_ctrl.dart';
import 'package:social_app/core/enums/message_enum.dart';
import 'package:social_app/core/utils/components/components.dart';
import 'package:social_app/features/data/models/chat_contact_model.dart';
import 'package:social_app/features/data/models/group.dart';
import 'package:social_app/features/data/models/message_model.dart';
import 'package:social_app/features/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/features/view/auth/auth_ctrl/auth_ctrl.dart';
import 'package:uuid/uuid.dart';


import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';
import '../../../data/models/message_reply_provider.dart';


// final chatRepositoryProvider = Provider(
//   (ref) => ChatRepository(
//     firestore: FirebaseFirestore.instance,
//     auth: FirebaseAuth.instance,
//   ),
// );

class ChatRepo {
  final ApiClient apiClient;
  ChatRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchAllChatContact() async {
    return await apiClient.getData('${AppString.BASE_URL}/');
  }

  Future<http.Response> fetchAllChatGroups() async {
    return await apiClient.getData('${AppString.BASE_URL}/');
  }

  Future<http.Response> fetchChat(String userId) async {
    return await apiClient.getData('${AppString.BASE_URL}/');
  }

  Future<http.Response> fetchGroupChat(String groudId) async {
    return await apiClient.getData('${AppString.BASE_URL}/');
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
    bool isGroupChat,
  ) async {
    if (isGroupChat) {
      await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'lastMessage': text,
        'timeSent': DateTime.now().millisecondsSinceEpoch,
      }),
    );
      // await firestore.collection('groups').doc(recieverUserId).update({
      //   'lastMessage': text,
      //   'timeSent': DateTime.now().millisecondsSinceEpoch,
      // });
    } else {
// users -> reciever user id => chats -> current user id -> set data
      var recieverChatContact = ChatContactModel(
        name: senderUserData.name,
        profilePic: senderUserData.photo,
        contactId: senderUserData.id,
        timeSent: timeSent,
        lastMessage: text,
      );
      await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'recieverChatContact': recieverChatContact.toMap(),
      }),
    );
      // await firestore
      //     .collection('users')
      //     .doc(recieverUserId)
      //     .collection('chats')
      //     .doc(auth.currentUser!.uid)
      //     .set(
      //       recieverChatContact.toMap(),
      //     );
      // users -> current user id  => chats -> reciever user id -> set data
      var senderChatContact = ChatContactModel(
        name: recieverUserData!.name,
        profilePic: recieverUserData.photo,
        contactId: recieverUserData.id,
        timeSent: timeSent,
        lastMessage: text,
      );
      await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'senderChatContact': senderChatContact.toMap(),
      }),
    );
      // await firestore
      //     .collection('users')
      //     .doc(auth.currentUser!.uid)
      //     .collection('chats')
      //     .doc(recieverUserId)
      //     .set(
      //       senderChatContact.toMap(),
      //     );
    }
  }

  void _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required MessageEnum messageType,
    required MessageReply? messageReply,
    required String senderUsername,
    required String? recieverUserName,
    required bool isGroupChat,
  }) async {
    final message = MessageModel(
      senderId: Get.find<UserCtrl>().user.id,
      recieverid: recieverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUsername
              : recieverUserName ?? '',
      repliedMessageType:
          messageReply == null ? MessageEnum.text : messageReply.messageEnum,
    );
    if (isGroupChat) {
      // groups -> group id -> chat -> message
      await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'message': message.toMap(),
      }),
    );
      // await firestore
      //     .collection('groups')
      //     .doc(recieverUserId)
      //     .collection('chats')
      //     .doc(messageId)
      //     .set(
      //       message.toMap(),
      //     );
    } else {
      // users -> sender id -> reciever id -> messages -> message id -> store message
      await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'message': message.toMap(),
      }),
    );
      // await firestore
      //     .collection('users')
      //     .doc(auth.currentUser!.uid)
      //     .collection('chats')
      //     .doc(recieverUserId)
      //     .collection('messages')
      //     .doc(messageId)
      //     .set(
      //       message.toMap(),
      //     );
      // users -> eciever id  -> sender id -> messages -> message id -> store message
      await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'message': message.toMap(),
      }),
    );
      // await firestore
      //     .collection('users')
      //     .doc(recieverUserId)
      //     .collection('chats')
      //     .doc(auth.currentUser!.uid)
      //     .collection('messages')
      //     .doc(messageId)
      //     .set(
      //       message.toMap(),
      //     );
    }
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      if (!isGroupChat) {
        recieverUserData = await Get.find<AuthCtrl>().fetchUserData(recieverUserId);
      }

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        recieverUserId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        username: senderUser.name,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.name,
        senderUsername: senderUser.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required UserModel senderUserData,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      int random = Random().nextInt(1000);

    final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
    String imageUrl = "";
    
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: "$random",
        ),
      );
      imageUrl = res.secureUrl;
    

      // String imageUrl = await ref
      //     .read(commonFirebaseStorageRepositoryProvider)
      //     .storeFileToFirebase(
      //       'chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId',
      //       file,
      //     );

      UserModel? recieverUserData;
      if (!isGroupChat) {
        // var userDataMap =
        //     await firestore.collection('users').doc(recieverUserId).get();
        recieverUserData = await Get.find<AuthCtrl>().fetchUserData(recieverUserId);
      }

      String contactMsg;

      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      _saveDataToContactsSubcollection(
        senderUserData,
        recieverUserData,
        contactMsg,
        timeSent,
        recieverUserId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: imageUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        messageType: messageEnum,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.name,
        senderUsername: senderUserData.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }


  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      if (!isGroupChat) {
        //var userDataMap = Get.find<AuthCtrl>().fetchUserData(recieverUserId);
            // await firestore.collection('users').doc(recieverUserId).get();
        recieverUserData = await Get.find<AuthCtrl>().fetchUserData(recieverUserId);
      }

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        'GIF',
        timeSent,
        recieverUserId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: gifUrl,
        timeSent: timeSent,
        messageType: MessageEnum.gif,
        messageId: messageId,
        username: senderUser.name,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.name,
        senderUsername: senderUser.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  Future<http.Response> setChatMessageSeen(
    String recieverUserId,
    String messageId,
  ) async {
    return await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'recieverId': recieverUserId,
        'messageId': messageId,
      }),
    );
    // try {
    //   await firestore
    //       .collection('users')
    //       .doc(auth.currentUser!.uid)
    //       .collection('chats')
    //       .doc(recieverUserId)
    //       .collection('messages')
    //       .doc(messageId)
    //       .update({'isSeen': true});

    //   await firestore
    //       .collection('users')
    //       .doc(recieverUserId)
    //       .collection('chats')
    //       .doc(auth.currentUser!.uid)
    //       .collection('messages')
    //       .doc(messageId)
    //       .update({'isSeen': true});
    // } catch (e) {
    //   Components.showCustomSnackBar(e.toString());
    // }
  }
}
