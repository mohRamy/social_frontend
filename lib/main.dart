import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'src/ramy_app.dart';
import 'src/config/application.dart';
import 'src/controller/app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Application().initialAppLication();
  Map<String, Map<String, String>> languages = await AppGet.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    ProviderScope(
      child: RamyApp(languages: languages),
    ),
  );
}

// if Application is in background, then it will work.
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   Get.to(
  //       () => ChatScreen(
  //         name: jsonDecode(jsonEncode(message.data))["name"],
  //         isGroupChat: false,
  //         photo: jsonDecode(jsonEncode(message.data))["photo"],
  //         userId: jsonDecode(jsonEncode(message.data))["userId"],
  //       ),
  //     );
  // });

  // // if Application is closed or terminiated, then it will work.
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null) {
  //     Get.to(
  //       () => ChatScreen(
  //         name: jsonDecode(jsonEncode(message.data))["name"],
  //         isGroupChat: false,
  //         photo: jsonDecode(jsonEncode(message.data))["photo"],
  //         userId: jsonDecode(jsonEncode(message.data))["userId"],
  //       ),
  //     );
  //   }
  // });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgoundHandler);

// Future<void> _firebaseMessagingBackgoundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("_firebaseMessagingBackgoundHandler: $message");
// }

// dVlz52K8R3GaNzEhVpjxIN:APA91bHy84xzt5VypQrhacfyjgz6K-WE5Chs3UqH1dSVSKAc98vAcKZxBJZNMRXVF-JxJJnwjP7pBxtY8uM41gilH4p5zWV_SIRnLmZ_z1SQ1pNUtvKVPekNYauVZ_Jb1_DdseubvIRK