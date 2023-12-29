import 'dart:async';

import 'package:get/get.dart';
import 'package:social_app/src/features/taps/requist/domain/usecases/change_user_case.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../screens/auth/data/models/auth_model.dart';

class RequistController extends GetxController with HandleLoading {
  final ChangeUserCaseRequistUseCase changeUserCaseUseCase;
  RequistController(
    this.changeUserCaseUseCase,
  );

  bool isFriend = false;
  FutureOr<void> changeUserCase(
    String userId,
    bool isDelete,
    int index,
  ) async {
    if (isDelete) {
      friendsInfo.removeAt(index);
    } else {
      isFriend = true;
    }
    // update();
    final result = await changeUserCaseUseCase(userId, isDelete);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
    update();
  }

  List<AuthModel> friendsInfo = [];
  FutureOr<void> getUsersInfo() async {
    if (AppGet.authGet.userData!.friendRequests.isNotEmpty) {
      List<String> friendsId = AppGet.authGet.userData!.friendRequests;
      for (var i = 0; i < friendsId.length; i++) {
        friendsInfo.add(
          await AppGet.authGet.fetchInfoUserById(
            friendsId[i],
          ),
        );
      }
    }
    update();
  }

  @override
  void onInit() {
    getUsersInfo();
    super.onInit();
  }
}
