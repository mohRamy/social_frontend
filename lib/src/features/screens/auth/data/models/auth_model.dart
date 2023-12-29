import 'dart:convert';

import 'package:social_app/src/resources/local/user_local.dart';

import '../../../../../public/constants.dart';
class AuthModel {
  final String id;
  final String name;
  final String email;
  final String bio;
  final List<String> friendRequests;
  final List<String> friends;
  final String photo;
  final String backgroundImage;
  final String phone;
  final String password;
  final String address;
  final String type;
  final bool private;
  final bool isOnline;
  // final DateTime lastActive;
  final String token;
  final String fcmToken;
  const AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
    required this.friendRequests,
    required this.friends,
    required this.photo,
    required this.backgroundImage,
    required this.phone,
    required this.password,
    required this.address,
    required this.type,
    required this.private,
    required this.isOnline,
    required this.token,
    required this.fcmToken,
  });
  // const AuthModel({
  //   required super.id,
  //   required super.name,
  //   required super.email,
  //   required super.bio,
  //   required super.followers,
  //   required super.following,
  //   required super.photo,
  //   required super.backgroundImage,
  //   required super.phone,
  //   required super.password,
  //   required super.address,
  //   required super.type,
  //   required super.private,
  //   required super.token,
  //   required super.fcmtoken,
  // });

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      friendRequests: List<String>.from(map['friendRequests'] ?? []),
      friends: List<String>.from(map['friends'] ?? []),
      photo: map['photo'] == AppConstants.urlImageDefault ||
              map['photo'] == null ||
              map['photo'] == ''
          ? AppConstants.urlImageDefault
          : map['photo'],
      backgroundImage: map['backgroundImage'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      private: map['private'] ?? false,
      isOnline: map['isOnline'] ?? false,
      // lastActive: DateTime.parse(map['lastActive']),
      token: map['token'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': UserLocal().getUserId(),
      'name': name,
      'email': email,
      'bio': bio,
      'friendRequests': friendRequests,
      'friends': friends,
      'photo': photo, 
      'backgroundImage': backgroundImage,
      'phone': phone,
      'password': password,
      'address': address,
      'type': type,
      'private': private,
      'isOnline': isOnline,
      // 'lastActive': format(lastActive),
      'token': token,
      'fcmToken': fcmToken,
    };
  }

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
