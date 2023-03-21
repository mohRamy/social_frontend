import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../controller/post_controller.dart';
import '../../../auth/presentation/controller/user_controller.dart';
import '../../../../core/enums/post_enum.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/components/profile_avatar.dart';
import '../../../../core/displaies/display_file_post.dart';

import '../../../../core/picker/picker.dart';
import '../../../../core/widgets/widgets.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final PostController postCtrl = Get.find<PostController>();

  final _keyForm = GlobalKey<FormState>();
  late List<AssetEntity> _mediaList = [];

  late File fileImage;

  @override
  void initState() {
    _assetImagesDevice();
    super.initState();
  }

  void selectImage() async {
    File? image = await pickImageFromCamera();
    if (image != null) {
      setState(() {
        postCtrl.imageFileSelected.add({
          PostEnum.image: image,
        });
      });
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery();
    if (video != null) {
      setState(() {
        postCtrl.imageFileSelected.add({
          PostEnum.video: video,
        });
      });
    }
  }

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 50);
        // getAssetListPaged(0, 50);
        setState(() => _mediaList = photos);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userBloc = BlocProvider.of<UserBloc>(context).state;
    // final postBloc = BlocProvider.of<PostBloc>(context);
    final size = MediaQuery.of(context).size;

    List<PostEnum> itemsKey = [];
    List<File> itemsVal = [];

    postCtrl.imageFileSelected
        .map((e) => e.forEach((key, value) {
              itemsKey.add(key);
            }))
        .toList();
    postCtrl.imageFileSelected
        .map((e) => e.forEach((key, value) {
              itemsVal.add(value);
            }))
        .toList();

    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _keyForm,
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
                          GetBuilder<UserController>(builder: (userCtrl) {
                            return Container(
                              alignment: Alignment.topLeft,
                              child: ProfileAvatar(
                                imageUrl: userCtrl.user.photo,
                                sizeImage: 50,
                              ),
                            );
                          }),
                          Container(
                            width: size.width * .78,
                            color: Colors.white,
                            child: TextFormField(
                              controller: postCtrl.descriptionC,
                              minLines: 1,
                              maxLines: 4,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 10.0, top: 10.0),
                                  border: InputBorder.none,
                                  hintText: 'Add a comment',
                                  hintStyle: TextStyle( 
                                  //GoogleFonts.roboto(
                                      fontSize: 17, 
                                      color: Colors.grey[700],
                                      )),
                              validator: RequiredValidator(
                                  errorText: 'This field is required'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 65.0, right: 10.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: postCtrl.imageFileSelected.length,
                          itemBuilder: (_, index) {
                            return Stack(
                              children: [
                                DisplayFilePost(
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
                                        postCtrl.imageFileSelected
                                            .removeAt(index);
                                      });
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                padding: const EdgeInsets.all(5),
                height: 90,

                width: size.width,
                // color: Colors.amber,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _mediaList.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () async {
                        fileImage = (await _mediaList[i].file)!;
                        setState(() {
                          postCtrl.imageFileSelected.add({
                            PostEnum.image: fileImage,
                          });
                        });
                      },
                      child: FutureBuilder(
                        future: _mediaList[i].thumbnailDataWithSize(
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
              ),
              const Divider(),
              const SizedBox(height: 5.0),
              SizedBox(
                height: 40,
                width: size.width,
                child: Row(
                  children: [
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          selectVideo();
                        },
                        icon: SvgPicture.asset('assets/svg/gallery.svg')),
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          selectImage();
                        },
                        icon: SvgPicture.asset('assets/svg/camera.svg')),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _appBarPost() {
    //final postBloc = BlocProvider.of<PostBloc>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          splashRadius: 20,
          onPressed: () {
            postCtrl.descriptionC.text = '';
            postCtrl.imageFileSelected.clear();
          },
          icon: const Icon(Icons.close_rounded)),
      GetBuilder<PostController>(builder: (postCtrl) {
        return TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                backgroundColor: AppColors.origin,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0))),
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                  postCtrl.addPost(
                    postCtrl.descriptionC.text,
                    postCtrl.imageFileSelected,
                  );
                  postCtrl.descriptionC.text = '';
                  postCtrl.imageFileSelected.clear();
                  setState(() {});
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
