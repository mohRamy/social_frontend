// import 'dart:convert';

// import '../../data/models/auth_model.dart';
// import '../../domain/entities/auth.dart';

// import 'package:get/get.dart';

// class UserController extends GetxController {
//   Auth _user = const Auth(
//     id: "",
//     name: "",
//     email: "",
//     bio: "",
//     followers: [],
//     following: [],
//     photo: "",
//     backgroundImage: "",
//     phone: "",
//     password: "",
//     address: "",
//     type: "",
//     private: false,
//     token: "",
//     fcmtoken: "",
//   );

//   Auth get user => _user;

//   void setUserFromJson(String user) {
//     _user = AuthModel.fromJson(jsonDecode(user));
//     update();
//   }

//   void setUserFromModel(Auth user) {
//     _user = user;
//     update();
//   }
// }
