import 'dart:async';

import 'package:get/get.dart';

import '../../domain/usecases/remove_friend.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../auth/data/models/auth_model.dart';

class FriendsController extends GetxController with HandleLoading {
  final RemoveFriendUseCase removeFriendUseCase;
  FriendsController(
    this.removeFriendUseCase,
  );

  FutureOr<void> removeFriend(
    String userId,
  ) async {
    final result = await removeFriendUseCase(userId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  Future<AuthModel> friendInfo(String userId) async {
    late AuthModel user;
    user = await AppGet.authGet.fetchInfoUserById(userId);
    update();
    return user;
  }
}
