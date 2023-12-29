import 'socket_emit.dart';

import '../../controller/app_controller.dart';
import '../../public/socket_gateway.dart';

import '../../config/application.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../public/components.dart';

IO.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = Application.socketUrl;
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder()
        .enableForceNew()
        .setTransports(['websocket']).setExtraHeaders({
      'authorization': AppGet.authGet.userData!.token,
    }).build(),
  );

  socket!.connect();

  socket!.onConnect((_) async {
    print('Connected');

    SocketEmit().signIn();

    // Is User Online
    socket!.on(SocketGateway.isedUserOnline, (data) {
      AppGet.authGet.isedUserOnline(data);
    });
    socket!.on(SocketGateway.isUserOnlineError, (data) {
      Components.showSnackBar(data['error'], title: "User Online");
    });

    // Get All Posts
    socket!.on(SocketGateway.goneAllPosts, (data) {
      AppGet.homeGet.goneAllPosts(data);
    });
    socket!.on(SocketGateway.getAllPostsError, (data) {
      Components.showSnackBar(data['error'], title: "Get All Posts");
    });

    // Change Post Like
    socket!.on(SocketGateway.changedPostLike, (data) {
      AppGet.homeGet.changedPostLike(data);
    });
    socket!.on(SocketGateway.changePostLikeError, (data) {
      Components.showSnackBar(data['error'], title: "Change Post Like");
    });

    // Change Story Like
    socket!.on(SocketGateway.changedStoryLike, (data) {
      AppGet.viewStoryGet.changedStoryLike(data);
    });
    socket!.on(SocketGateway.changeStoryLikeError, (data) {
      Components.showSnackBar(data['error'], title: "Change Story Like");
    });

    // Add Comment
    socket!.on(SocketGateway.addedComment, (data) {
      AppGet.commentGet.addedComment(data);
    });
    socket!.on(SocketGateway.addCommentError, (data) {
      Components.showSnackBar(data['error'], title: "Add Comment Post");
    });


    // Change Comment Like
    socket!.on(SocketGateway.changedCommentLike, (data) {
      AppGet.commentGet.changedCommentLike(data);
    });
    socket!.on(SocketGateway.changeCommentLikeError, (data) {
      Components.showSnackBar(data['error'], title: "Add Like Comment Post");
    });

    // Add Share Post
    socket!.on(SocketGateway.addPostShare, (data) {
      AppGet.homeGet.addedPostShare(data);
    });
    socket!.on(SocketGateway.addPostShareError, (data) {
      Components.showSnackBar(data['error'], title: "Add Share Post");
    });

    // Update Avatar
    socket!.on(SocketGateway.updatedAvatar, (data) {
      AppGet.profileGet.updatedAvatar(data);
    });
    socket!.on(SocketGateway.updateAvatarError, (data) {
      Components.showSnackBar(data['error'], title: "Update Avatar Error");
    });

    // Update User Info
    socket!.on(SocketGateway.updatedUserInfo, (data) {
      AppGet.updateInfoGet.updatedUserInfo(data);
    });
    socket!.on(SocketGateway.updateUserInfoError, (data) {
      Components.showSnackBar(data['error'], title: "Update User Info Error");
    });

    // Change User Case User
    socket!.on(SocketGateway.changedUserCase, (data) {
      // AppGet.requist.changeedUserCase(data);
    });
    socket!.on(SocketGateway.changeUserCaseError, (data) {
      Components.showSnackBar(data['error'], title: "Change User Case Error");
    });

    // Add Message
    socket!.on(SocketGateway.addedMessage, (data) {
      AppGet.chatGet.addedMessage(data);
    });
    socket!.on(SocketGateway.addMessageError, (data) {
      Components.showSnackBar(data['error'], title: "Add Message");
    });

    // Is Message Seen
    socket!.on(SocketGateway.isedMessageSeen, (data) {
      AppGet.chatGet.isedMessageSeen(data);
    });
    socket!.on(SocketGateway.isMessageSeenError, (data) {
      Components.showSnackBar(data['error'], title: "Add Message");
    });


    socket!.onDisconnect((_) => print('Disconnected'));
  });
}

void disconnectBeforeConnect() {
  if (socket != null && socket!.connected) {
    socket!.disconnect();
  }
}
