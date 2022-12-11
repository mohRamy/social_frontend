
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/user_ctrl.dart';
import 'package:social_app/features/auth/auth_ctrl/auth_ctrl.dart';
import 'package:social_app/features/nav/nav_ctrl/nav_user_ctrl.dart';

import '../data/api/api_client.dart';
import '../core/utils/app_strings.dart';
import '../features/auth/auth_repo/auth_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //sharedPreferences
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  
  //repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => UserCtrl());
  Get.lazyPut(() => NavUserCtrl());
  Get.lazyPut(() => AuthCtrl(apiClient: Get.find(), authRepo: Get.find(), sharedPreferences: sharedPreferences));
}
