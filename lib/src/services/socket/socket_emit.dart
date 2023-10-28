import 'package:social_app/src/resources/local/user_local.dart';

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

  // Add Message
  addMessage(
    String senderId,
    String recieverId,
    String message,
    String type,
    String repliedMessage,
    String repliedType,
    String repliedTo,
    bool repliedIsMe,
  ) {
    socket!.emit(
      SocketGateway.addMessage,
      {
        'senderId': senderId,
        'recieverId': recieverId,
        'message': message,
        'type': type,
        'repliedMessage': repliedMessage,
        'repliedType': repliedType,
        'repliedTo': repliedTo,
        'repliedIsMe': repliedIsMe,
      },
    );
  }
}
