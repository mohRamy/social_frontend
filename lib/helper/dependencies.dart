import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:social_app/core/network/network_info.dart';
import '../controller/user_ctrl.dart';

import '../features/data/api/api_client.dart';
import '../features/data/api/local_source.dart';
import '../features/view/auth/auth_ctrl/auth_ctrl.dart';
import '../features/view/auth/auth_repo/auth_repo.dart';
import '../features/view/home/home_ctrl/home_ctrl.dart';
import '../features/view/home/home_repo/home_repo.dart';
import '../features/view/nav/nav_ctrl/nav_user_ctrl.dart';
import '../features/view/post/post_ctrl/post_ctrl.dart';
import '../features/view/post/post_repo/post_repo.dart';
import '../features/view/profile/profile_ctrl/profile_ctrl.dart';
import '../features/view/profile/profile_repo/profile_repo.dart';
import '../features/view/search/search_ctrl/search_ctrl.dart';
import '../features/view/search/search_repo/search_repo.dart';
import '../features/view/story/data_sources/story_local_data_source.dart';
import '../features/view/story/story_ctrl/story_ctrl.dart';
import '../features/view/story/data_sources/story_remote_data_source.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //sharedPreferences
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));

  //netInfo
  Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
  Get.lazyPut(() => InternetConnectionChecker());

  // localSource
  Get.lazyPut(() => PostLocalSource(sharedPreferences: Get.find()));
  Get.lazyPut(() => StoryLocalSource(sharedPreferences: Get.find()));


  //repos
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepo(
        apiClient: Get.find(),
      ));
  Get.lazyPut(() => PostRepo(apiClient: Get.find()));
  Get.lazyPut(() => StoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => SearchRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => UserCtrl());
  Get.lazyPut(
    () => HomeCtrl(
      homeRepo: Get.find(),
      networkInfo: Get.find(),
      postLocalSource: Get.find(),
      storyLocalSource: Get.find(),
    ),
  );
  Get.lazyPut(() => NavUserCtrl());
  Get.lazyPut(
    () => AuthCtrl(
      apiClient: Get.find(),
      authRepo: Get.find(),
      sharedPreferences: sharedPreferences,
    ),
  );
  Get.lazyPut(() => PostCtrl(postRepo: Get.find()));
  Get.lazyPut(() => StoryCtrl(storyRepo: Get.find()));
  Get.lazyPut(() => SearchCtrl(searchRepo: Get.find()));
  Get.lazyPut(() => ProfileCtrl(profileRepo: Get.find()));
}
