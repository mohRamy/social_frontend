import 'package:get/get.dart';
import 'package:social_app/src/controller/app_controller.dart';

import 'package:social_app/src/core/error/handle_error_loading.dart';
import 'package:social_app/src/features/taps/home/data/models/post_model.dart';
import 'package:social_app/src/features/taps/watch/domain/usecases/get_post_watch.dart';

class WatchController extends GetxController with HandleLoading {
  final GetPostWatchUseCase getPostWatchUseCase;
  WatchController(
    this.getPostWatchUseCase,
  );

  List<PostModel> postWatch = [];
  void getPostWatch(){
    print('pppppppppppppp');
    for (var i = 0; i < AppGet.homeGet.posts.length; i++) {
      for (var j = 0; j < AppGet.homeGet.posts[i].posts.length; j++) {
        if (AppGet.homeGet.posts[i].posts[j].type == 'video') {
          postWatch.add(AppGet.homeGet.posts[i]);
        }
      }
    }
    print(postWatch);
    update();
  }

  @override
  void onInit() {
    getPostWatch();
    super.onInit();
  }
}
