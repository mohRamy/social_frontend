import 'dart:convert';

import 'comment_model.dart';
import 'user_model.dart';

// class PostModel {
//   final String id;
//   final String userId;
//   final String userName;
//   final String userPhoto;
//   final String description;
//   final List<Map<String, String>> posts;
//   final List<UserModel> likes;
//   final int time;
//   final List<CommentModel> comments;
//   PostModel({
//     required this.id,
//     required this.userId,
//     required this.userName,
//     required this.userPhoto,
//     required this.description,
//     required this.posts,
//     required this.likes,
//     required this.time,
//     required this.comments,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'userName': userName,
//       'userPhoto': userPhoto,
//       'description': description,
//       'posts': posts,
//       'likes': likes.map((x) => x.toMap()).toList(),
//       'time': time,
//       'comments': comments.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory PostModel.fromMap(Map<String, dynamic> map) {
//     return PostModel(
//       id: map['_id'] ?? '',
//       userId: map['userId'] ?? '',
//       userName: map['userName'] ?? '',
//       userPhoto: map['userPhoto'] ?? '',
//       description: map['description'] ?? '',
//       posts: List<Map<String, String>>.from(map['posts']?.map((x) => x)),
//       likes: List<UserModel>.from(map['likes']?.map((x) => UserModel.fromMap(x))??[]),
//       time: map['time']?.toInt() ?? 0,
//       comments: List<CommentModel>.from(map['comments']?.map((x) => CommentModel.fromMap(x))??[]),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source));

//   PostModel copyWith({
//     String? id,
//     String? userId,
//     String? userName,
//     String? userPhoto,
//     String? description,
//     List<Map<String, String>>? posts,
//     List<UserModel>? likes,
//     int? time,
//     List<CommentModel>? comments,
//   }) {
//     return PostModel(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       userName: userName ?? this.userName,
//       userPhoto: userPhoto ?? this.userPhoto,
//       description: description ?? this.description,
//       posts: posts ?? this.posts,
//       likes: likes ?? this.likes,
//       time: time ?? this.time,
//       comments: comments ?? this.comments,
//     );
//   }
// }

class PostModel {
  String? _id;
  UserModel? _userData;
  String? _userId;
  int? _time;
  List<Posts>? _posts;
  List<String>? _likes;
  List<CommentModel>? _comments;
  String? _description;

  PostModel(
      {
      String? id,
      UserModel? userData,
      String? userId,
      int? time,
      List<Posts>? posts,
      List<String>? likes,
      List<CommentModel>? comments,
      String? description}) {
    if (id != null) {
      _id = id;
    }
    if (userData != null) {
      _userData = userData;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (time != null) {
      _time = time;
    }
    if (posts != null) {
      _posts = posts;
    }
    if (likes != null) {
      _likes = likes;
    }
    if (comments != null) {
      _comments = comments;
    }
    if (description != null) {
      _description = description;
    }
  }


  String? get id => _id;
  set id(String? id) => _id = id;
  UserModel? get userData => _userData;
  set userData(UserModel? userData) => _userData = userData;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  int? get time => _time;
  set time(int? time) => _time = time;
  List<Posts>? get posts => _posts;
  set posts(List<Posts>? posts) => _posts = posts;
  List<String>? get likes => _likes;
  set likes(List<String>? likes) => _likes = likes;
  List<CommentModel>? get comments => _comments;
  set comments(List<CommentModel>? comments) => _comments = comments;
  String? get description => _description;
  set description(String? description) => _description = description;

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
    id: map['_id']??map['id'],
    userData: UserModel.fromMap(map['userData']),
    userId: map['userId'] ?? '',
    time: map['time']??0,
    posts : List<Posts>.from(map['posts']?.map((x) => Posts.fromJson(x))??[]),
    likes : List<String>.from(map['likes']??[]),
    comments: List<CommentModel>.from(map['comments']?.map((x) => CommentModel.fromMap(x))??[]),
    description: map['description']??"",
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['userData'] = _userData;
    data['userId'] = _userId;
    data['time'] = _time;
    if (_posts != null) {
      data['posts'] = _posts!.map((v) => v.toJson()).toList();
    }
    if (_likes != null) {
      data['likes'] = _likes;
    }
    if (_comments != null) {
      data['comments'] = _comments!.map((v) => v.toJson()).toList();
    }
    data['description'] = _description;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}

class Posts {
  String? _post;
  String? _type;

  Posts({String? post, String? type}) {
    if (post != null) {
      _post = post;
    }
    if (type != null) {
      _type = type;
    }
  }

  String? get post => _post;
  set post(String? post) => _post = post;
  String? get type => _type;
  set type(String? type) => _type = type;

  Posts.fromJson(Map<String, dynamic> json) {
    _post = json['post'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post'] = _post;
    data['type'] = _type;
    return data;
  }

  
}
