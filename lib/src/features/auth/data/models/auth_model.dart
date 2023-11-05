import 'dart:convert';
class AuthModel {
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
  final bool private;
  final String token;
  final String fcmtoken;
  const AuthModel({
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
    required this.private,
    required this.token,
    required this.fcmtoken,
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

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
