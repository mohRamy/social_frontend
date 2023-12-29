import 'dart:async';

import 'package:get/get.dart';
import 'package:social_app/src/controller/app_controller.dart';

import 'package:social_app/src/core/error/handle_error_loading.dart';
import 'package:social_app/src/features/screens/view_story/domain/usecases/change_story_like.dart';

class ViewStoryController extends GetxController with HandleLoading {
  final ChangeStoryLikeUsecase changeStoryLikeUsecase;
  ViewStoryController(
    this.changeStoryLikeUsecase,
  );

  // List<String> storyLikes = [];
  // Map<String, int> countStoryLikes = {};

  changeLike(String storyId) {
    if (AppGet.homeGet.storyLikes.contains(storyId)) {
      AppGet.homeGet.storyLikes.remove(storyId);
      AppGet.homeGet.countStoryLikes[storyId] = AppGet.homeGet.countStoryLikes[storyId]! - 1;
    } else {
      AppGet.homeGet.storyLikes.add(storyId);
      AppGet.homeGet.countStoryLikes[storyId] = AppGet.homeGet.countStoryLikes[storyId]! + 1;
    }
    update();
  }

  FutureOr<void> changeStoryLike(String storyId) async {
    changeLike(storyId);
    final result = await changeStoryLikeUsecase(storyId);
    result.fold(
      (l) => handleLoading(l),
      (r) {},
    );
    update();
  }

  void changedStoryLike(dynamic data) {
    update();
  }
}
