import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../controllers/add_story_controller.dart';
import '../../../../../themes/app_colors.dart';

import '../../../../../core/displaies/display_file_story.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../public/components.dart';
import '../../../../../utils/sizer_custom/sizer.dart';

class AddStoryScreen extends GetView<AddStoryController> {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              controller.selectImage();
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
            width: Dimensions.size15,
          ),
          InkWell(
            onTap: () {
              controller.selectVideo();
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const TextCustom(
          text: 'Add Story',
          fontSize: 19,
          letterSpacing: .8,
        ),
        leading: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close)),
        actions: [
          GetBuilder<AddStoryController>(
            builder: (addStoryCtrl)=> TextButton(
              onPressed: () {
                if (controller.imageFileSelected.isNotEmpty) {
                  addStoryCtrl.addStory();
                } else {
                  Components.showSnackBar('Check that you click photos', title: 'Error');
                }
              },
              child: TextCustom(
                text: 'puplic',
                fontSize: 17,
                color: colorPrimary,
              ),
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
          padding: EdgeInsets.only(
            top: Dimensions.size10,
            left: Dimensions.size10,
            right: Dimensions.size10,
          ),
          child: SizedBox(
            height: Dimensions.screenHeight / 2,
            width: Dimensions.screenWidth,
            child: Obx(
              ()=> GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2 / 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.imageFileSelected.length,
                itemBuilder: (_, index) {
                  return Stack(
                    children: [
                      DisplayFileStory(
                        file: controller.itemsVal()[index],
                        type: controller.itemsKey()[index],
                      ),
                      Positioned(
                          top: 5,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              controller.removePhoto(index);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black38,
                              child: Icon(Icons.close_rounded, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            height: Dimensions.screenHeight / 3,
            width: Dimensions.screenWidth,
            color: Colors.black,
            child: GetBuilder<AddStoryController>(
              builder: (addStoryCtrl) {
                return GridView.builder(
                  itemCount: addStoryCtrl.mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 2/2,
                  ),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () async {
                        addStoryCtrl.addFile((await addStoryCtrl.mediaList[i].file)!);
                      },
                      child: FutureBuilder(
                        future: addStoryCtrl.mediaList[i].thumbnailDataWithSize(
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
                );
              }
            ),
          ),
        ),
      ]),
    );
  }
}
