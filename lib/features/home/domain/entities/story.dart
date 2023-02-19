import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/auth.dart';
import '../../../data/models/comment_model.dart';

class Story extends Equatable {
  final String id;
  final Auth userData;
  final DateTime createdAt;
  final List<Stories> stories;
  final List<String> likes;
  final List<CommentMode> comments;
  const Story({
    required this.id,
    required this.userData,
    required this.createdAt,
    required this.stories,
    required this.likes,
    required this.comments,
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Stories extends Equatable {
  final String story;
  final String type;
  const Stories({
    required this.story,
    required this.type,
  });
  
  @override
  List<Object?> get props => [
    story,
    type,
  ];
}
