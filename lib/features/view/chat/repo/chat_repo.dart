import 'dart:convert';
import 'dart:math';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:social_app/features/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/components/components.dart';
import '../../../data/api/api_client.dart';
import '../../../data/models/chat_model.dart';


class ChatRepo {
  final ApiClient apiClient;
  ChatRepo({
    required this.apiClient,
  });

  Future<http.Response> fetchAllChatContact() async {
    return await apiClient.getData(AppString.CHAT_GET_URL);
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

  Future<http.Response> sendMsg({
    required Msg msg,
    required RepliedMsg? repliedMsg,
    required String recieverId,
    required UserModel senderUser,
    required bool isGroupChat,
  }) async {
    if (msg.type == 'image' || msg.type == 'video') {
      int random = Random().nextInt(1000);
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          msg.message!,
          folder: "$random",
        ),
      );
      msg.message = res.secureUrl;
    }

    if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
      int random = Random().nextInt(1000);

      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          repliedMsg.repliedMessage!,
          folder: "$random",
        ),
      );
      repliedMsg.repliedMessage = res.secureUrl;
    }

    // if (isGroupChat) {
    //   await apiClient.postData(
    //     AppString.SIGN_IN_URL,
    //     jsonEncode({
    //       'message': message.toMap(),
    //     }),
    //   );
    // } else {
    return await apiClient.postData(
      AppString.MESSAGE_ADD_URL,
      jsonEncode({
        'recieverId': recieverId,
        'message': msg.message,
        'type': msg.type,
        'repliedMessage': repliedMsg.repliedMessage,
        'repliedType': repliedMsg.type,
        'repliedTo': repliedMsg.repliedTo,
        'repliedIsMe': repliedMsg.isMe,
      }),
    );
  }

  void setChatMessageSeen(
    String recieverUserId,
    String messageId,
  ) async {
    try {
      // await firestore
      //     .collection('users')
      //     .doc(auth.currentUser!.uid)
      //     .collection('chats')
      //     .doc(recieverUserId)
      //     .collection('messages')
      //     .doc(messageId)
      //     .update({'isSeen': true});

      // await firestore
      //     .collection('users')
      //     .doc(recieverUserId)
      //     .collection('chats')
      //     .doc(auth.currentUser!.uid)
      //     .collection('messages')
      //     .doc(messageId)
      //     .update({'isSeen': true});
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }
}
