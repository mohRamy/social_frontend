import 'package:get/get.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../auth/data/models/auth_model.dart';

class LikeController extends GetxController with HandleLoading {
  Future<List<AuthModel>> getUsersInfo(List<String> usersId) async {
    List<AuthModel> users = [];
    for (var i = 0; i < usersId.length; i++) {
      users.add(
        await AppGet.authGet.fetchInfoUserById(
          usersId[i],
        ),
      );
    }
    return users;
  }
}
