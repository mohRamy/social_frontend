import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/auth.dart';
import '../../data/models/comment_model.dart';

class Post extends Equatable {
  final String id;
  final Auth userData;
  final String userId;
  final int time;
  final List<Posts> posts;
  final List<String> likes;
  final List<CommentModel> comments;
  final String? description;
  const Post({
    required this.id,
    required this.userData,
    required this.userId,
    required this.time,
    required this.posts,
    required this.likes,
    required this.comments,
    this.description,
  });
  @override
  List<Object?> get props => [
    id,
    userData,
    userId,
    time,
    posts,
    likes,
    comments,
    description,
  ];
}

class Posts extends Equatable {
  final String post;
  final String type;
  const Posts({
    required this.post,
    required this.type,
  });
  
  @override
  List<Object?> get props => [
    post,
    type,
  ];
}


