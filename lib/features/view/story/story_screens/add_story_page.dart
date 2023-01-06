import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/view/story/story_ctrl/story_ctrl.dart';
import 'package:social_app/features/view/story/story_widgets/display_text_image_gif.dart';

import '../../../../core/enums/story_enum.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextCustom(
          text: 'Galeria',
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
      body: Column(children: [
        Padding(
                        padding: const EdgeInsets.only(left: 65.0, right: 10.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: storyCtrl.imageFileSelected.length,
                          itemBuilder: (_, index) {
                            return Stack(
                              children: [
                                DisplayFileStory(
                                  type: itemsKey[index],
                                  message: itemsVal[index],
                                ),
                                // Container(
                                //   height: 150,
                                //   width: size.width * .95,
                                //   margin: const EdgeInsets.only(bottom: 10.0),
                                //   decoration: BoxDecoration(
                                //     color: Colors.blue,
                                //     borderRadius: BorderRadius.circular(10.0),
                                //     image: DecorationImage(
                                //       fit: BoxFit.cover,
                                //       image: FileImage(
                                //         postCtrl.imageFileSelected[i],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        storyCtrl.imageFileSelected
                                            .removeAt(index);
                                      });
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black38,
                                      child: Icon(Icons.close_rounded,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
        // Container(
        //     height: size.height * .4,
        //     width: size.width,
        //     decoration: BoxDecoration(
        //       color: Colors.black87,
        //       // image: DecorationImage(
        //       //     fit: BoxFit.cover,
        //       //     image: FileImage(state.image!)
        //       //     )
        //     )),

        // :
        // Container(
        //     height: size.height * .4,
        //     width: size.width,
        //     color: Colors.black87,
        //     child: const Icon(Icons.wallpaper_rounded,
        //         color: Colors.white, size: 90),
        //   ),
        Expanded(
          child: Container(
            height: size.height,
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
