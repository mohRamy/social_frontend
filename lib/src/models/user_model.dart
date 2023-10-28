import 'dart:convert';

import '../config/application.dart';
import '../public/constants.dart';

class UserModel {
  final String id;
  final String image;
  final String blurHash;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String type;
  final String tokenFCM;
  final String token;
  final List<String>? favorites;

  UserModel({
    required this.id,
    required this.image,
    required this.blurHash,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.type,
    required this.tokenFCM,
    required this.token,
    this.favorites,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'blurHash': blurHash,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'type': type,
      'tokenFCM': tokenFCM,
      'token': token,
      'favorites': favorites,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      image: map['image'] == AppConstants.urlImageDefault ||
              map['image'] == null ||
              map['image'] == ''
          ? AppConstants.urlImageDefault
          : map['image'].toString().contains('http')
              ? map['image']
              : (Application.imageUrl + map['image']),
      blurHash: map['blurHash'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      tokenFCM: map['tokenFCM'] ?? '',
      token: map['token'] ?? '',
      favorites: List<String>.from(map['favorites']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? image,
    String? blurHash,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? type,
    String? tokenFCM,
    String? token,
    List<String>? favorites,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      blurHash: blurHash ?? this.blurHash,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      tokenFCM: tokenFCM ?? this.tokenFCM,
      token: token ?? this.token,
      favorites: favorites ?? this.favorites,
    );
  }
}
