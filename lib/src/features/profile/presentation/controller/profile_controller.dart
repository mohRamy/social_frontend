import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_clouding.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';
import '../../../../controller/app_controller.dart';
import '../../../../themes/app_colors.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../../../public/components.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/follow_user.dart';
import '../../domain/usecases/get_user_posts.dart';
import '../../domain/usecases/get_user_posts_by_id.dart';
import '../../domain/usecases/modify_my_data.dart';
import '../../domain/usecases/private_account.dart';

import '../../../auth/domain/entities/auth.dart';
class ProfileController extends GetxController with HandleLoading {
  final FollowUserUseCase followUserUseCase;
  final GetUserPostsUseCase getUserPostsUseCase;
  final GetUserPostsByIdUseCase getUserPostsByIdUseCase;
  final UpdataUserInfoUseCase updataUserInfoUseCase;
  final PrivateAccountUseCase privateAccountUseCase;
  final ChangepasswordUseCase changepasswordUseCase;
  ProfileController({
    required this.followUserUseCase,
    required this.getUserPostsUseCase,
    required this.getUserPostsByIdUseCase,
    required this.updataUserInfoUseCase,
    required this.privateAccountUseCase,
    required this.changepasswordUseCase,
  });

  bool isFriend = false;

  FutureOr<void> changeFollowingUser(String userId) async {
    final result = await followUserUseCase(userId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  void changedFollowingUser (dynamic data){
    // Auth user = AuthModel.fromMap(data);
    // print('bbbbvvvvvvvvvvvvvvvvvvvv');
    // isFriend = !isFriend;
    // print(isFriend);
    update();
  }

  Future<List<PostModel>> getUserPosts() async {
    List<PostModel> userPosts = [];
    final result = await getUserPostsUseCase();
    result.fold(
      (l) => handleLoading(l),
      (r) => userPosts = r,
    );
    update();
    return userPosts;
  }

  Future<List<PostModel>> getUserPostsById(String userId) async {
    List<PostModel> userPostsById = [];
    final result = await getUserPostsByIdUseCase(userId);
    result.fold(
      (l) => handleLoading(l),
      (r) => userPostsById = r,
    );
    update();
    return userPostsById;
  }

  FutureOr<void> updateUserInfo(
    String name,
    String bio,
    String email,
    String address,
    String phone,
    File? photo,
    File? backgroundImage,
  ) async {
    showLoading();

    String photoCloud = '';
    if (photo != null) {
      photoCloud = await cloudinaryPuplic(photo.path);
    } else {
      photoCloud = AppGet.authGet.userData!.photo;
    }

    String backgroundImageCloud = '';
    if (backgroundImage != null) {
      backgroundImageCloud = await cloudinaryPuplic(backgroundImage.path);
    } else {
      backgroundImageCloud = AppGet.authGet.userData!.backgroundImage;
    }

    Auth myData = Auth(
      id: "",
      name: name,
      email: email,
      bio: bio,
      followers: const [],
      following: const [],
      photo: photoCloud,
      backgroundImage: backgroundImageCloud,
      phone: phone,
      password: "",
      address: address,
      type: "",
      private: false,
      token: "",
      fcmtoken: "",
    );

    final result = await updataUserInfoUseCase(myData);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        hideLoading();
        update();
        Components.showSnackBar(
        "Updated Your Information!",
        title: "Successful",
        color: colorPrimary,
      );
      },
    );

    update();
  }

  FutureOr<void> privateAccount() async {
    showLoading();
    final result = await privateAccountUseCase();
    result.fold(
      (l) => handleLoading(l),
      (r) {
        hideLoading();
        update();
        Components.showSnackBar(
        "Your Account Private!",
        title: "Private",
        color: colorPrimary,
      );
      }
    );

    update();
  }

  FutureOr<void> changepassword(
    String currentPassword,
    String newPassword,
  ) async {
    showLoading();

    final result = await changepasswordUseCase(currentPassword, newPassword);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    hideLoading();
    update();
  }
}
