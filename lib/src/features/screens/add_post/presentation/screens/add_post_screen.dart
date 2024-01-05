import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../../controller/app_controller.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';

import '../../../../../core/displaies/display_file.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../taps/home/presentation/components/profile_avatar.dart';
import '../controllers/add_post_controller.dart';

class AddPostScreen extends GetView<AddPostController> {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('create_post'.tr),
        bottom: PreferredSize(
          preferredSize: Size(Dimensions.screenWidth, Dimensions.size5),
          child: const Divider(),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _appBarPost(),
            const SizedBox(height: 10.0),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: ProfileAvatar(
                            imageUrl: AppGet.authGet.userData!.photo,
                            sizeImage: 50,
                          ),
                        ),
                        SizedBox(width: Dimensions.size5),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: AppTextField(
                              textController: controller.descriptionController,
                              hintText: 'what_do_you_think'.tr,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(left: 65.0, right: 10.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.imageFileSelected.length,
                          itemBuilder: (_, index) {
                            return Stack(
                              children: [
                                DisplayFile(
                                  file: controller.itemsVal()[index],
                                  type: controller.itemsKey()[index],
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
                                //         postCtrl.imageFileSelected[index],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: InkWell(
                                    onTap: () {
                                      controller.removePhoto(index);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black38,
                                      child: Icon(
                                        Icons.close_rounded,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            GetBuilder<AddPostController>(builder: (addPostCtrl) {
              return Container(
                padding: const EdgeInsets.all(5),
                height: 90,

                width: Dimensions.screenWidth,
                // color: Colors.amber,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: addPostCtrl.mediaList.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () async {
                        addPostCtrl
                            .addFile((await addPostCtrl.mediaList[i].file)!);
                      },
                      child: FutureBuilder(
                        future: addPostCtrl.mediaList[i].thumbnailDataWithSize(
                            const ThumbnailSize(200, 200)),
                        builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              height: 85,
                              width: 100,
                              margin: const EdgeInsets.only(right: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(
                                    snapshot.data!,
                                  ),
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
              );
            }),
            const Divider(),
            const SizedBox(height: 5.0),
            SizedBox(
              height: 40,
              width: Dimensions.screenWidth,
              child: Row(
                children: [
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        controller.selectVideo();
                      },
                      icon: SvgPicture.asset('assets/svg/gallery.svg')),
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        controller.selectImage();
                      },
                      icon: SvgPicture.asset('assets/svg/camera.svg')),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _appBarPost() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          splashRadius: 20,
          onPressed: () {
            controller.descriptionController.text = '';
            controller.imageFileSelected.clear();
          },
          icon: const Icon(Icons.close_rounded)),
      GetBuilder<AddPostController>(builder: (addPostCtrl) {
        return TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                backgroundColor: colorPrimary,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0))),
            onPressed: () {
              if (controller.descriptionController.text != "" ||
                  controller.imageFileSelected != []) {
                addPostCtrl.addPost(
                  addPostCtrl.descriptionController.text,
                  addPostCtrl.imageFileSelected,
                );
              }
            },
            child: const TextCustom(
              text: 'public',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: .7,
            ));
      }),
    ]);
  }
}
