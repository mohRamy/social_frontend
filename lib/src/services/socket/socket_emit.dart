import '../../features/chat/data/models/chat_model.dart';
import '../../resources/local/user_local.dart';

import 'socket.dart';
import '../../public/socket_gateway.dart';

class SocketEmit {
  // Get All Posts
  getAllPosts() {
    socket!.emit(
      SocketGateway.getAllPosts,
      {
        'userId': UserLocal().getUserId(),
      },
    );
  }

  // Change Like Post
  changeLikePostEmit(String postId) {
    socket!.emit(
      SocketGateway.changeLikePost,
      {
        'postId': postId,
        'userId': UserLocal().getUserId(),
      },
    );
  }

  // Add Comment Post
  addCommentPostEmit(String postId, String comment) {
    socket!.emit(
      SocketGateway.addCommentPost,
      {
        'postId': postId,
        'userId': UserLocal().getUserId(),
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
        'userId': UserLocal().getUserId(),
        'commentId': commentId,
      },
    );
  }

  // Change Following User
  changeFollowingUser(String userId) {
    socket!.emit(
      SocketGateway.changeFollowingUser,
      {
        'myId': UserLocal().getUserId(),
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
