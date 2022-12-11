import '../models/user_model.dart';
import 'package:get/get.dart';

class UserCtrl extends GetxController{
  UserModel _user = UserModel(
    id: '', 
    name: '', 
    email: '', 
    bio: '', 
    followers: [], 
    following: [], 
    photo: '', 
    backgroundImage: '', 
    phone: '', 
    password: '', 
    address: '', 
    type: '', 
    token: '',
    );

  UserModel get user => _user;

  void setUserFromJson(String user) {
    _user = UserModel.fromJson(user);
    update();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    update();
  }
}