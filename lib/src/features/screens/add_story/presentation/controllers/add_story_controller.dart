import 'dart:io';
import 'package:get/get.dart';

import 'package:photo_manager/photo_manager.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/enums/story_enum.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../core/picker/picker.dart';
import '../../../../../core/widgets/app_clouding.dart';
import '../../../../../public/components.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../domain/usecases/add_story.dart';

class AddStoryController extends GetxController with HandleLoading {
  final AddStoryUsecase addStoryUsecase;
  AddStoryController(
    this.addStoryUsecase,
  );

  @override
  void onInit() {
    _assetImagesDevice();
    super.onInit();
  }

  @override
  void dispose() {
    imageFileSelected.value = [];
    super.dispose();
  }

  List<AssetEntity> mediaList = [];
  RxList<Map<StoryEnum, File>> imageFileSelected =
      <Map<StoryEnum, File>>[].obs;

    _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 90);
        mediaList = photos;
        update();
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  void selectImage() async {
    File? image = await pickImageFromCamera();
    if (image != null) {
      imageFileSelected.add({
        StoryEnum.image: image,
      });
    }
    update();
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      imageFileSelected.add({
        StoryEnum.video: video,
      });
    }
  }

  void addFile(File file) {
    imageFileSelected.add({
      StoryEnum.image: file,
    });
  }

  void removePhoto(int index) {
    imageFileSelected.removeAt(index);
  }

  List<StoryEnum> itemsKey() {
    List<StoryEnum> items = [];
    imageFileSelected
        .map(
          (e) => e.forEach(
            (key, value) {
              items.add(key);
            },
          ),
        )
        .toList();
        return items;
  }

  List<File> itemsVal() {
    List<File> items = [];
    imageFileSelected
        .map(
          (e) => e.forEach(
            (key, value) {
              items.add(value);
            },
          ),
        )
        .toList();
    return items;
  }

  void addStory() async {
    try {
      print('ddddddddddddddddddddd');
      showLoading();
      List<String> storiesType = [];
      List<String> storiesUrl = [];

      for (var i = 0; i < itemsKey().length; i++) {
        switch (itemsKey()[i]) {
          case StoryEnum.image:
            storiesType.add("image");
            break;
          case StoryEnum.video:
            storiesType.add("video");
            break;
          default:
            storiesType.add("image");
        }
      }

      for (var i = 0; i < itemsVal().length; i++) {
        storiesUrl.add(await cloudinaryPublic(itemsVal()[i].path));
      }

      final result = await addStoryUsecase(storiesUrl, storiesType);
      result.fold(
        (l) => handleLoading(l),
        (r) {
          imageFileSelected.value = [];
          hideLoading();
          update();
          Components.showSnackBar(
            "added your Story",
            title: "Added successfully",
            color: colorPrimary,
          );
          AppNavigator.pop();
          AppGet.homeGet.getAllStories();
          update();
        },
      );
    } catch (e) {
      hideLoading();
      update();
      Components.showSnackBar(e.toString());
    }
  }
}
