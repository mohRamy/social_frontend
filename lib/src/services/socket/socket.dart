import 'package:social_app/src/controller/app_controller.dart';
import 'package:social_app/src/public/socket_gateway.dart';

import '../../config/application.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../public/components.dart';
import '../../resources/local/user_local.dart';

IO.Socket? socket;

void connectAndListen() {
  disconnectBeforeConnect();
  String socketUrl = Application.socketUrl;
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder()
        .enableForceNew()
        .setTransports(['websocket']).setExtraHeaders({
      'authorization': UserLocal().getAccessToken(),
    }).build(),
  );

  socket!.connect();
  socket!.onConnect((_) async {
    print('Connected');

    // Get All Posts
    socket!.on(SocketGateway.goneAllPosts, (data) {
      AppGet.homeGet.goneAllPosts(data);
    });
    socket!.on(SocketGateway.getAllPostsError, (data) {
      Components.showSnackBar(data['error'], title: "Get All Posts");
    });

    // Change Like Status
    socket!.on(SocketGateway.changedlikePost, (data) {
      AppGet.homeGet.addedLikePost(data);
    });
    socket!.on(SocketGateway.changeLikePostError, (data) {
      Components.showSnackBar(data['error'], title: "Change Like Status");
    });

    // Add Comment Post
    socket!.on(SocketGateway.addedCommentPost, (data) {
      AppGet.homeGet.addedCommentPost(data);
    });

    socket!.on(SocketGateway.addCommentPostError, (data) {
      Components.showSnackBar(data['error'], title: "Add Comment Post");
    });


    // Change Like Comment Post
    socket!.on(SocketGateway.changedLikeCommentPost, (data) {
      AppGet.homeGet.addedLikeCommentPost(data);
    });

    socket!.on(SocketGateway.changeLikeCommentPostError, (data) {
      Components.showSnackBar(data['error'], title: "Add Like Comment Post");
    });

    // Change Following User
    socket!.on(SocketGateway.changedFollowingUser, (data) {
      AppGet.profileGet.changedFollowingUser(data);
    });

    socket!.on(SocketGateway.changeFollowingUserError, (data) {
      Components.showSnackBar(data['error'], title: "Add Like Comment Post");
    });

    // Add Message
    socket!.on(SocketGateway.addedMessage, (data) {
      AppGet.chatGet.addedMessage(data);
    });
    socket!.on(SocketGateway.addMessageError, (data) {
      Components.showSnackBar(data['error'], title: "Add Message");
    });


    socket!.onDisconnect((_) => print('Disconnected'));
  });

  socket!.connect();
}

void disconnectBeforeConnect() {
  if (socket != null && socket!.connected) {
    socket!.disconnect();
  }
}
