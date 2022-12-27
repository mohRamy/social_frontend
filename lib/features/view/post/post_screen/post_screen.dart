import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../controller/user_ctrl.dart';
import '../../../../core/enums/message_enum.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/components/components.dart';
import '../post_ctrl/post_ctrl.dart';
import '../post_widgets/display_text_image_gif.dart';

import '../../../../core/picker/picker.dart';
import '../../../../core/widgets/widgets.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final PostCtrl postCtrl = Get.find<PostCtrl>();

  final _keyForm = GlobalKey<FormState>();
  late List<AssetEntity> _mediaList = [];

  late File fileImage;

  @override
  void initState() {
    _assetImagesDevice();
    super.initState();
  }

  void selectImage() async {
    File? image = await pickImageFromGallery();
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
      backgroundColor: Colors.white,
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
                          GetBuilder<UserCtrl>(builder: (userCtrl) {
                            return Container(
                              alignment: Alignment.topLeft,
                              height: 120,
                              width: size.width * .125,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  userCtrl.user.photo,
                                ),
                              ),
                            );
                          }),
                          Container(
                            height: 100,
                            width: size.width * .78,
                            color: Colors.white,
                            child: TextFormField(
                              controller: postCtrl.descriptionC,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 10.0, top: 10.0),
                                  border: InputBorder.none,
                                  hintText: 'Add a comment',
                                  hintStyle: GoogleFonts.roboto(fontSize: 18)),
                              validator: RequiredValidator(
                                  errorText: 'This field is required'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 65.0, right: 10.0),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: postCtrl.imageFileSelected.length,
                              itemBuilder: (_, index) {
                                return Stack(
                                  children: [
                                    DisplayTextImageGIF(
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
                                          child: Icon(Icons.close_rounded,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }))
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
              
              InkWell(
                // onTap: () => modalPrivacyPost(context),
                onTap: () {},
                child: Row(
                  children: const [
                    // BlocBuilder<PostBloc, PostState>(builder: (_, state) {
                    //   if (state.privacyPost == 1) {
                    //     return const Icon(Icons.public_rounded);
                    //   }
                    //   if (state.privacyPost == 2) {
                    //     return const Icon(Icons.group_outlined);
                    //   }
                    //   if (state.privacyPost == 3) {
                    //     return const Icon(Icons.lock_outline_rounded);
                    //   }
                    //   return const SizedBox();
                    // }),
                    SizedBox(width: 5.0),
                    // BlocBuilder<PostBloc, PostState>(builder: (_, state) {
                    //   if (state.privacyPost == 1) {
                    //     return const TextCustom(
                    //         text: 'Todos pueden comentar', fontSize: 16);
                    //   }
                    //   if (state.privacyPost == 2) {
                    //     return const TextCustom(
                    //         text: 'Solo seguidores', fontSize: 16);
                    //   }
                    //   if (state.privacyPost == 3) {
                    //     return const TextCustom(
                    //         text: 'Nadie', fontSize: 16);
                    //   }
                    //   return const SizedBox();
                    // }),
                  ],
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
                          // AppPermission()
                          //     .permissionAccessGalleryMultiplesImagesNewPost(
                          //   await Permission.storage.request(),
                          //   context,
                          // );
                        },
                        icon: SvgPicture.asset('assets/svg/gallery.svg')),
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          selectImage();
                          // AppPermission()
                          //     .permissionAccessGalleryOrCameraForNewPost(
                          //   await Permission.camera.request(),
                          //   context,
                          //   ImageSource.camera,
                          // );
                        },
                        icon: SvgPicture.asset('assets/svg/camera.svg')),
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/svg/gif.svg')),
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/svg/location.svg')),
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
          // onPressed: () => Navigator.pushAndRemoveUntil(
          //     context, routeSlide(page: const HomePage()), (_) => false),
          onPressed: () {},
          icon: const Icon(Icons.close_rounded)),
      GetBuilder<PostCtrl>(builder: (postCtrl) {
        return TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                backgroundColor: AppColors.primary,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0))),
            onPressed: () {
              List<File> posts = [];
              postCtrl.imageFileSelected
                  .map((e) => e.forEach((key, value) {
                        posts.add(value);
                      }))
                  .toList();
              if (_keyForm.currentState!.validate()) {
                if (postCtrl.imageFileSelected.isNotEmpty) {
                  postCtrl.addPost(
                    description: postCtrl.descriptionC.text,
                    posts: postCtrl.imageFileSelected,
                  );
                  postCtrl.descriptionC.text = '';
                  postCtrl.imageFileSelected.clear();
                  setState(() {});
                } else {
                  Components.showCustomSnackBar('error');
                }
              }
            },
            child: const TextCustom(
              text: 'publishing',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: .7,
            ));
      }),
    ]);
  }
}
