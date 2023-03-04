import 'dart:convert';

import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.id,
    required super.name,
    required super.email,
    required super.bio,
    required super.followers,
    required super.following,
    required super.photo,
    required super.backgroundImage,
    required super.phone,
    required super.password,
    required super.address,
    required super.type,
    required super.private,
    required super.token,
    required super.fcmtoken,
  });

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      photo: map['photo'] ?? '',
      backgroundImage: map['backgroundImage'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      private: map['private'] ?? false,
      token: map['token'] ?? '',
      fcmtoken: map['fcmtoken'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'followers': followers,
      'following': following,
      'photo': photo,
      'backgroundImage': backgroundImage,
      'phone': phone,
      'password': password,
      'address': address,
      'type': type,
      'private': private,
      'token': token,
      'fcmtoken': fcmtoken,
    };
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));
}
