import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/follow_user.dart';
import '../../domain/usecases/get_user_post.dart';
import '../../domain/usecases/modify_my_data.dart';
import '../../domain/usecases/private_account.dart';

import '../../../auth/presentation/controller/user_controller.dart';
import '../../../../core/utils/app_component.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../home/domain/entities/post.dart';

class ProfileController extends GetxController with HandleErrorLoading {
  final FollowUserUseCase followUserUseCase;
  final GetUserPostUseCase getUserPostUseCase;
  final ModifyMyDataUseCase modifyMyDataUseCase;
  final PrivateAccountUseCase privateAccountUseCase;
  final ChangepasswordUseCase changepasswordUseCase;
  ProfileController({
    required this.followUserUseCase,
    required this.getUserPostUseCase,
    required this.modifyMyDataUseCase,
    required this.privateAccountUseCase,
    required this.changepasswordUseCase,
  });

  FutureOr<void> followUser(String userId) async {
    final result = await followUserUseCase(userId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    update();
  }

  List<Post> userPosts = [];
  FutureOr<void> getUserPost(String userId) async {
    final result = await getUserPostUseCase(userId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => userPosts = r,
    );
    update();
  }

  FutureOr<void> modifyMyData(
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
      photoCloud = Get.find<UserController>().user.photo;
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
      backgroundImageCloud = Get.find<UserController>().user.backgroundImage;
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

    final result = await modifyMyDataUseCase(myData);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    hideLoading();
    update();
  }

  FutureOr<void> privateAccount() async {
    final result = await privateAccountUseCase();
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    update();
  }

  FutureOr<void> changepassword(
      String currentPassword, String newPassword) async {
    showLoading();

    final result = await changepasswordUseCase(currentPassword, newPassword);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    hideLoading();
    update();
  }
}
