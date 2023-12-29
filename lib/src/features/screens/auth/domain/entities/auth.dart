import 'package:equatable/equatable.dart';

class Auth extends Equatable {
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
  const Auth({
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

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        bio,
        followers,
        following,
        photo,
        backgroundImage,
        phone,
        password,
        address,
        type,
        private,
        token,
        fcmtoken,
      ];
}
