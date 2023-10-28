import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import 'package:social_app/src/resources/local/user_local.dart';
import 'package:social_app/src/themes/app_colors.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../../../public/components.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/follow_user.dart';
import '../../domain/usecases/get_user_posts.dart';
import '../../domain/usecases/get_user_posts_by_id.dart';
import '../../domain/usecases/modify_my_data.dart';
import '../../domain/usecases/private_account.dart';

import '../../../auth/domain/entities/auth.dart';
import '../../../home/domain/entities/post.dart';

class ProfileController extends GetxController with HandleErrorLoading {
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
      (l) => handleError(l),
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

  Future<List<Post>> getUserPosts() async {
    List<Post> userPosts = [];
    final result = await getUserPostsUseCase();
    result.fold(
      (l) => handleError(l),
      (r) => userPosts = r,
    );
    update();
    return userPosts;
  }

  Future<List<Post>> getUserPostsById(String userId) async {
    List<Post> userPostsById = [];
    final result = await getUserPostsByIdUseCase(userId);
    result.fold(
      (l) => handleError(l),
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
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      int random = Random().nextInt(1000);

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          photo.path,
          folder: "$name $random",
        ),
      );
      photoCloud = res.secureUrl;
    } else {
      photoCloud = UserLocal().getUser()!.photo;
    }

    String backgroundImageCloud = '';
    if (backgroundImage != null) {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      int random = Random().nextInt(1000);

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          backgroundImage.path,
          folder: "$name $random",
        ),
      );
      backgroundImageCloud = res.secureUrl;
    } else {
      backgroundImageCloud = UserLocal().getUser()!.backgroundImage;
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
      (l) => handleError(l),
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
      (l) => handleError(l),
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
      (l) => handleError(l),
      (r) => null,
    );

    hideLoading();
    update();
  }
}
