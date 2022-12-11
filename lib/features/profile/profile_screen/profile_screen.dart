import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/user_ctrl.dart';
import 'package:social_app/core/utils/app_colors.dart';

import '../../../core/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              _CoverAndProfile(size: size),
              const SizedBox(height: 10.0),
              const _UsernameAndDescription(),
              const SizedBox(height: 30.0),
              const _PostAndFollowingAndFollowers(),
              const SizedBox(height: 30.0),
            
              const SizedBox(height: 20.0),
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.0),
                child: 
                //  const _ListFotosProfile()
                          _ListSaveProfile()),
              
            ],
          ),
          );
  
  }
}

class _ListFotosProfile extends StatelessWidget {
  const _ListFotosProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      mainAxisExtent: 170),
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    

                    return InkWell(
                      // onTap: () => Navigator.push(context,
                      //     routeSlide(page: const ListPhotosProfilePage())),
                      child: Container(
                        alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: NetworkImage(
                        //             Environment.baseUrl + listImages.first))),
                      ),
                    );
                  },
                );
        
  }
}

class _ListSaveProfile extends StatelessWidget {
  const _ListSaveProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
              itemCount: 34,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 2, mainAxisExtent: 170),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                
                return InkWell(
                  
                  child: Container(
                      alignment: Alignment.center,
                      child: Text('dff'),
                      ),
                );
  });
    
  }
}

class _PostAndFollowingAndFollowers extends StatelessWidget {
  const _PostAndFollowingAndFollowers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      width: size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                   TextCustom(
                              text: 'dfdf',
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                          
                  const TextCustom(
                      text: 'Post',
                      fontSize: 17,
                      color: Colors.grey,
                      letterSpacing: .7),
                ],
              ),
              InkWell(
                
                child: Column(
                  children: const [
                    TextCustom(
                                text: 'dfdf',
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                            
                     TextCustom(
                        text: 'Siguiendo',
                        fontSize: 17,
                        color: Colors.grey,
                        letterSpacing: .7),
                  ],
                ),
              ),
              InkWell(
                
                child: Column(
                  children: const [
                     TextCustom(
                                    text: 'erere',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                                
                     TextCustom(
                        text: 'Seguidores',
                        fontSize: 17,
                        color: Colors.grey,
                        letterSpacing: .7),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UsernameAndDescription extends StatelessWidget {
  const _UsernameAndDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserCtrl>(
      builder: (userCtrl) {
        return Column(
          children: [
            Center(
                child: TextCustom(
                    text: Get.find<UserCtrl>().user.type, fontSize: 22, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5.0),
            Center(
                child: TextCustom(
                    text: (userCtrl.user.email), fontSize: 17, color: Colors.grey)),
          ],
        );
      }
    );
  }
}

class _CoverAndProfile extends StatelessWidget {
  const _CoverAndProfile({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: size.width,
      child: Stack(
        children: [
          SizedBox(
              height: 170,
              width: size.width,
              child: Container(
                height: 170,
                width: size.width,
                color: AppColors.primary.withOpacity(.7),
              )),
          Positioned(
            bottom: 28,
            child: Container(
              height: 20,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0))),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: size.width,
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    // onTap: () => modalSelectPicture(
                    //   context: context,
                    //   title: 'Actualizar image de perfil',
                    //   onPressedImage: () async {

                    //     Navigator.pop(context);
                    //     AppPermission().permissionAccessGalleryOrCameraForProfile(await Permission.storage.request(), context, ImageSource.gallery);
                    //   },
                    //   onPressedPhoto: () async {

                    //     Navigator.pop(context);
                    //     AppPermission().permissionAccessGalleryOrCameraForProfile(await Permission.camera.request(), context, ImageSource.camera);
                    //   }
                    // ),
                    child: Container(),
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage( Environment.baseUrl + state.user!.image )
                    // ),
                  )),
            ),
          ),
          Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {},
                // onPressed: () => modalProfileSetting(context, size),
                icon: const Icon(Icons.dashboard_customize_outlined,
                    color: Colors.white),
              )),
          Positioned(
              right: 40,
              child: IconButton(
                splashRadius: 20,
                onPressed: () {},
                // onPressed: () => modalSelectPicture(
                //   context: context,
                //   title: 'Actualizar imagen de portada',
                //   onPressedImage: () async {

                //     // Navigator.pop(context);
                //     // AppPermission().permissionAccessGalleryOrCameraForCover(await Permission.storage.request(), context, ImageSource.gallery);

                //   },
                //   onPressedPhoto: () async {

                //     // Navigator.pop(context);
                //     // AppPermission().permissionAccessGalleryOrCameraForCover(await Permission.camera.request(), context, ImageSource.camera);
                //   }
                // ),
                icon: const Icon(Icons.add_box_outlined, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
