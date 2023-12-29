import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';

import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../core/picker/picker.dart';
import '../../../../../core/widgets/app_clouding.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../taps/home/data/models/post_model.dart';
import '../../domain/usecases/get_user_posts.dart';
import '../../domain/usecases/update_avatar.dart';

class ProfileController extends GetxController with HandleLoading {
  final GetUserPostsUseCase getUserPostsUseCase;
  final UpdateAvatarUseCase updateAvatarUseCase;
  ProfileController(
    this.getUserPostsUseCase,
    this.updateAvatarUseCase,
  );

  File? backgroundImageFile;
  File? photoFile;

  void selectImageFromCamera(bool isPhoto) async {
    File? image = await pickImageFromCamera();
    if (image != null) {
      if (isPhoto) {
        photoFile = image;
        updateAvatar(photoFile, true);
      } else {
        backgroundImageFile = image;
        updateAvatar(backgroundImageFile, false);
      }
    }
    AppNavigator.pop();
    update();
  }

  void selectImageFromGallery(bool isPhoto) async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      if (isPhoto) {
        photoFile = image;
        updateAvatar(photoFile, true);
      } else {
        backgroundImageFile = image;
        updateAvatar(backgroundImageFile, false);
      }
    }
    AppNavigator.pop();
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

  FutureOr<void> updateAvatar(File? photo, bool isPhoto) async {
    String photoCloud = '';
    if (photo != null) {
      photoCloud = await cloudinaryPublic(photo.path);

      final result = await updateAvatarUseCase(photoCloud, isPhoto);
      result.fold(
        (l) => handleLoading(l),
        (r) {},
      );
    }

    update();
  }

  void updatedAvatar(dynamic data){}
}
