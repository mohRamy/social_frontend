import 'dart:async';

import 'package:get/get.dart';

import '../../../../../core/error/handle_error_loading.dart';
import '../../domain/usecases/change_user_case.dart';
import '../../domain/usecases/get_another_user_posts.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/enums/friend_enum.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../taps/home/data/models/post_model.dart';
import '../../../auth/data/models/auth_model.dart';

class AnotherProfileController extends GetxController with HandleLoading {
  final ChangeUserCaseUseCase changeUserCaseUseCase;
  final GetAnotherUserPostsUseCase getAnotherUserPostsUseCase;

  AnotherProfileController(
    this.changeUserCaseUseCase,
    this.getAnotherUserPostsUseCase,
  );

  UserCaseEnum userEnum = UserCaseEnum.notrequestAndFriend;

  Future<AuthModel> userInfo(String userId) async {
    late AuthModel user;
    user = await AppGet.authGet.fetchInfoUserById(userId);
    update();
    return user;
  }

  void userEnim(AuthModel? userInfo) {
    if (userInfo!.friendRequests.contains(UserLocal().getUserId())) {
      userEnum = UserCaseEnum.userRequest;
    } else if (UserLocal().getUser()!.friendRequests.contains(userInfo.id)) {
      userEnum = UserCaseEnum.myRequest;
    } else if (userInfo.friends.contains(UserLocal().getUserId())) {
      userEnum = UserCaseEnum.friend;
    } else {
      userEnum = UserCaseEnum.notrequestAndFriend;
    }
    update();
  }

  FutureOr<void> changeUserCase(
    String userId,
    bool isDelete,
  ) async {
    switch (userEnum) {
      case UserCaseEnum.notrequestAndFriend:
        userEnum = UserCaseEnum.userRequest;
        break;
      case UserCaseEnum.userRequest:
        userEnum = UserCaseEnum.notrequestAndFriend;
        break;
      case UserCaseEnum.myRequest:
        if (isDelete) {
          userEnum = UserCaseEnum.notrequestAndFriend;
        } else {
          userEnum = UserCaseEnum.friend;
        }
        break;
      case UserCaseEnum.friend:
        userEnum = UserCaseEnum.notrequestAndFriend;
        break;
      default:
        userEnum = UserCaseEnum.notrequestAndFriend;
    }
    update();
    final result = await changeUserCaseUseCase(userId, isDelete);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  Future<List<PostModel>> getAnotherUserPosts(String userId) async {
    List<PostModel> anotherUserPosts = [];
    final result = await getAnotherUserPostsUseCase(userId);
    result.fold(
      (l) => handleLoading(l),
      (r) => anotherUserPosts = r,
    );
    update();
    return anotherUserPosts;
  }
}
