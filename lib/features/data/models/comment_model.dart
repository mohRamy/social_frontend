import 'dart:convert';

import 'user_model.dart';

class CommentModel {
  final String id;
  final UserModel userData;
  final String comment;
  final List<UserModel> likes;
  final int time;
  CommentModel({
    required this.id,
    required this.userData,
    required this.comment,
    required this.likes,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userData': userData.toMap(),
      'comment': comment,
      'likes': likes.map((x) => x.toMap()).toList(),
      'time': time,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['_id'] ?? '',
      userData: UserModel.fromMap(map['userData']),
      comment: map['comment'] ?? '',
      likes: List<UserModel>.from(map['likes']?.map((x) => UserModel.fromMap(x))??[]),
      time: map['time']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source));

  CommentModel copyWith({
    String? id,
    UserModel? userData,
    String? comment,
    List<UserModel>? likes,
    int? time,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userData: userData ?? this.userData,
      comment: comment ?? this.comment,
      likes: likes ?? this.likes,
      time: time ?? this.time,
    );
  }
}
