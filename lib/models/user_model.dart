import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String bio;
  final List<String> followers;
  final List<String> following;
  final String photo;
  final String backgroundImage;
  final String phone;
  final String password;
  final String address;
  final String type;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photo,
    required this.backgroundImage,
    required this.phone,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

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
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      photo: map['photo'] ?? '',
      backgroundImage: map['backgroundImage'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? bio,
    List<String>? followers,
    List<String>? following,
    String? photo,
    String? backgroundImage,
    String? phone,
    String? password,
    String? address,
    String? type,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      photo: phone ?? this.photo,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }
}
