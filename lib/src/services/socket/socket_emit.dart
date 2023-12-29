import 'package:social_app/src/features/screens/auth/data/models/auth_model.dart';

import '../../resources/local/user_local.dart';

import '../../features/screens/chat/data/models/chat_model.dart';
import 'socket.dart';
import '../../public/socket_gateway.dart';

class SocketEmit {
  // SignIn
  signIn() {
    socket!.emit(
      SocketGateway.signIn,
      UserLocal().getUserId(),
    );
  }

  // Is User Online
  isUserOnline(bool isOnline) {
    var data = {
      "user-id": UserLocal().getUserId(),
      "is-user-online": isOnline,
    };
    socket!.emit(
      SocketGateway.isUserOnline,
      data,
    );
  }

  // Get All Posts
  getAllPosts() {
    socket!.emit(
      SocketGateway.getAllPosts,
      {
        'user-id': UserLocal().getUserId(),
      },
    );
  }

  // Change Post Like
  changePostLikeEmit(String postId) {
    socket!.emit(
      SocketGateway.changePostLike,
      {
        'post-id': postId,
        'user-id': UserLocal().getUserId(),
      },
    );
  }

  // Change Story Like
  changeStoryLikeEmit(String storyId) {
    socket!.emit(
      SocketGateway.changeStoryLike,
      {
        'story-id': storyId,
        'user-id': UserLocal().getUserId(),
      },
    );
  }

  // Add Comment
  addCommentEmit(
    String itemId,
    String itemType,
    String comment,
  ) {
    socket!.emit(
      SocketGateway.addComment,
      {
        'item-id': itemId,
        'item-type': itemType,
        'user-id': UserLocal().getUserId(),
        'comment': comment,
      },
    );
  }

  // Change Comment Like
  changeCommentLikeEmit(
    String postId,
    String itemType,
    String commentId,
  ) {
    socket!.emit(
      SocketGateway.changeCommentLike,
      {
        'item-id': postId,
        'item-type': itemType,
        'user-id': UserLocal().getUserId(),
        'comment-id': commentId,
      },
    );
  }

  // Add Post Share
  addPostShare(String postId) {
    socket!.emit(
      SocketGateway.addPostShare,
      {
        'post-id': postId,
        'user-id': UserLocal().getUserId(),
      },
    );
  }

  // Add Story Share
  addStoryShare(String storyId) {
    socket!.emit(
      SocketGateway.addStoryShare,
      {
        'story-id': storyId,
        'user-id': UserLocal().getUserId(),
      },
    );
  }

  // Update Avatar
  updateAvatar(String photo, bool isPhoto) {
    socket!.emit(
      SocketGateway.updateAvatar,
      {
        'user-id': UserLocal().getUserId(),
        'photo': photo,
        'is-photo': isPhoto,
      },
    );
  }

  // Update User Info
  updateUserInfo(AuthModel userInfo) {
    socket!.emit(
      SocketGateway.updateUserInfo,
      userInfo.toMap(),
    );
  }

  // Change User Case
  changeUserCase(String userId, bool isDelete) {
    socket!.emit(
      SocketGateway.changeUserCase,
      {
        'my-id': UserLocal().getUserId(),
        'user-id': userId,
        'is-delete': isDelete,
      },
    );
  }

  // Join Room Chat
  joinRoomChat({required String idConversation}) {
    socket!.emit(SocketGateway.joinRoomChat, {
      'id-conversation': idConversation,
    });
  }

  // Leave Room Chat
  leaveRoomChat({required String idConversation}) {
    socket!.emit(SocketGateway.leaveRoomChat, {
      'id-conversation': idConversation,
    });
  }

  // Add Message
  addMessage(
    String idConversation,
    MessageModel message,
  ) {
    var body = {
      "id-conversation": idConversation,
      "message": message.toJson(),
    };

    socket!.emit(
      SocketGateway.addMessage,
      body,
    );
  }

  // Is Message Seen
  isMessageSeen(
    String recieverId,
  ) {
    var data = {
      "sender-id": recieverId,
      "reciever-id": UserLocal().getUserId(),
    };
    socket!.emit(
      SocketGateway.isMessageSeen,
      data,
    );
  }
}
