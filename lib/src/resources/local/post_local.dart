import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';
import 'package:social_app/src/features/home/domain/entities/post.dart';

class PostLocal {
  final _getStorage = GetStorage();
  final postsKey = 'posts';
  
  void savePosts(List<Post> posts) async {
    _getStorage.write(postsKey, posts);
  }

  List<Post?> getPosts() {
    var response = _getStorage.read(postsKey);    
    if (response != null) {
      List<Post> posts = [];
      List rawData = response;
      posts = rawData.map((e) => PostModel.fromMap(json.decode(e))).toList();
      return posts;
    }
    return [];
  }

  void clearPosts() async {
    _getStorage.remove(postsKey);
  }
}
