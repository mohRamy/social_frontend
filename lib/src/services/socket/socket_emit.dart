import '../../controller/app_controller.dart';
import '../../features/chat/data/models/chat_model.dart';

import '../../helper/device_helper.dart';
import '../../models/device_model.dart';
import 'socket.dart';
import '../../public/socket_gateway.dart';

class SocketEmit {
    sendDeviceInfo() async {
    DeviceModel deviceModel = await getDeviceDetails();
    socket!.emit(
      SocketGateway.sendFCMTokenCSS,
      deviceModel.toMap(),
    );
  }
  // Get All Posts
  getAllPosts() {
    socket!.emit(
      SocketGateway.getAllPosts,
      {
        'userId': AppGet.authGet.userData!.id,
      },
    );
  }

  // Change Like Post
  changeLikePostEmit(String postId) {
    socket!.emit(
      SocketGateway.changeLikePost,
      {
        'postId': postId,
        'userId': AppGet.authGet.userData!.id,
      },
    );
  }

  // Add Comment Post
  addCommentPostEmit(String postId, String comment) {
    socket!.emit(
      SocketGateway.addCommentPost,
      {
        'postId': postId,
        'userId': AppGet.authGet.userData!.id,
        'comment': comment,
      },
    );
  }

  // Change Like Comment Post
  changeLikeCommentPostEmit(String postId, String commentId) {
    socket!.emit(
      SocketGateway.changeLikeCommentPost,
      {
        'postId': postId,
        'userId': AppGet.authGet.userData!.id,
        'commentId': commentId,
      },
    );
  }

  // Change Following User
  changeFollowingUser(String userId) {
    socket!.emit(
      SocketGateway.changeFollowingUser,
      {
        'myId': AppGet.authGet.userData!.id,
        'userId': userId,
      },
    );
  }

  // Join Room Chat
  joinRoomChat({required String idConversation}) {
    socket!.emit(SocketGateway.joinRoomChat, {
      'idConversation': idConversation,
    });
  }

  // Leave Room Chat
  leaveRoomChat({required String idConversation}) {
    socket!.emit(SocketGateway.leaveRoomChat, {
      'idConversation': idConversation,
    });
  }

  // Add Message
  addMessage(
    String idConversation,
    MessageModel message,
  ) {
    var body = {
      "idConversation": idConversation,
      "message": message.toJson(),
    };
    
    socket!.emit(
      SocketGateway.addMessage,
      body,
    );
  }
}
