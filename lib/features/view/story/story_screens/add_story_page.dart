import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/dimensions.dart';
import 'package:social_app/features/view/story/story_ctrl/story_ctrl.dart';
import 'package:social_app/features/view/story/story_widgets/display_file_story.dart';

import '../../../../core/enums/story_enum.dart';
import '../../../../core/picker/picker.dart';
import '../../../../core/utils/components/components.dart';
import '../../../../core/widgets/widgets.dart';
import '../../post/post_widgets/display_text_image_gif.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final StoryCtrl storyCtrl = Get.find<StoryCtrl>();
  late List<AssetEntity> _mediaList = [];

  final StoryCtrl postCtrl = Get.find<StoryCtrl>();

  late File fileImage;

  @override
  void initState() {
    _assetImagesDevice();
    super.initState();
  }

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 90);

        setState(() => _mediaList = photos);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  void selectImage() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      setState(() {
        postCtrl.imageFileSelected.add({
          StoryEnum.image: image,
        });
      });
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      setState(() {
        postCtrl.imageFileSelected.add({
          StoryEnum.video: video,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<StoryEnum> itemsKey = [];
    List<File> itemsVal = [];

    storyCtrl.imageFileSelected
        .map((e) => e.forEach((key, value) {
              itemsKey.add(key);
            }))
        .toList();
    storyCtrl.imageFileSelected
        .map((e) => e.forEach((key, value) {
              itemsVal.add(value);
            }))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (){
              selectImage();
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.width15,
          ),
          InkWell(
            onTap: (){
              selectVideo();
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.video_camera_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextCustom(
          text: 'Add Story',
          fontSize: 19,
          letterSpacing: .8,
        ),
        leading: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.black87)),
        actions: [
          TextButton(
            onPressed: () {
              if (storyCtrl.imageFileSelected.isNotEmpty) {
                storyCtrl.addStory(
                  story: storyCtrl.imageFileSelected,
                );
                setState(() {});
              } else {
                Components.showCustomSnackBar('error');
              }
            },
            child: TextCustom(
              text: 'puplic',
              fontSize: 17,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
          ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10.0, right: 10.0),
          child: 
                SizedBox(
                  height: Dimensions.screenHeight / 2,
                  width: Dimensions.screenWidth,
                  child: GridView.builder(
                    gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 2 / 2,
                          ),
                    physics: const BouncingScrollPhysics(),
                    
                    itemCount: storyCtrl.imageFileSelected.length,
                    itemBuilder: (_, index) {
                      return Stack(
                        children: [
                          DisplayFileStory(
                            type: itemsKey[index],
                            message: itemsVal[index],
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  storyCtrl.imageFileSelected.removeAt(index);
                                });
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.black38,
                                child: Icon(Icons.close_rounded, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            
          
        
        Positioned(
          bottom: 0.0,
          child: Container(
              height: Dimensions.screenHeight / 3,
              width: size.width,
              color: Colors.black,
              child: GridView.builder(
                itemCount: _mediaList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () async {
                      fileImage = (await _mediaList[i].file)!;
                      setState(
                        () {
                          storyCtrl.imageFileSelected.add({
                            StoryEnum.image: fileImage,
                          });
                        },
                      );
                    },
                    child: FutureBuilder(
                      future: _mediaList[i].thumbnailDataWithSize(
                        const ThumbnailSize(200, 200),
                      ),
                      builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            height: 85,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(snapshot.data!),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        
      ]),
    );
  }
}
