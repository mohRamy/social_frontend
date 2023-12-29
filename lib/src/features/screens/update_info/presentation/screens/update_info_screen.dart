import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/controller/app_controller.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/features/screens/auth/data/models/auth_model.dart';
import 'package:social_app/src/features/screens/auth/index.dart';
import 'package:social_app/src/features/screens/update_info/presentation/controllers/update_info_cotnroller.dart';
import 'package:social_app/src/routes/app_pages.dart';

import '../../../../../core/widgets/hero_image.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../public/components.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';

class UpdateInfoScreen extends GetView<UpdateInfoController> {
  const UpdateInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

    buildBottomsheet(UpdateInfoController updateInfoCtrl, bool isPhoto) =>
        Get.bottomSheet(
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Dimensions.size15),
                ),
                color: Get.isDarkMode ? colorBlack : mCL,
              ),
              padding: const EdgeInsetsDirectional.only(
                top: 4,
              ),
              width: Dimensions.screenWidth,
              height: 170.sp,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      height: 6,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.size20,
                        ),
                        color: Get.isDarkMode
                            ? Colors.grey[600]
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.size10),
                  Components.buildbottomsheet(
                    icon: Icon(
                      Icons.person_2_sharp,
                      color: colorBlack,
                    ),
                    label: "Show Profile Image",
                    ontap: () => Get.to(
                      HeroImage(
                        image: isPhoto
                            ? AppGet.authGet.userData!.photo
                            : AppGet.authGet.userData!.backgroundImage,
                      ),
                    ),
                  ),
                  Components.buildbottomsheet(
                    icon: Icon(
                      Icons.camera_alt,
                      color: colorBlack,
                    ),
                    label: "Select Image From camera",
                    ontap: () => updateInfoCtrl.selectImageFromCamera(isPhoto),
                  ),
                  Components.buildbottomsheet(
                    icon: Icon(
                      Icons.photo_library,
                      color: colorBlack,
                    ),
                    label: "Select Image From Gallery",
                    ontap: () => updateInfoCtrl.selectImageFromGallery(isPhoto),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0.4,
        );

    Widget buildEdit(String text, Function()? onTap) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(text),
            GestureDetector(
              onTap: onTap,
              child: Text(
                'Edit'.tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: colorPrimary,
                    ),
              ),
            ),
          ],
        );

    Widget buildDetails(String text, IconData icon) => InkWell(
          onTap: () => AppNavigator.push(AppRoutes.updateInfoDetails),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.size5),
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: Dimensions.size10),
                AppText(text),
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppText('update_profile'.tr),
        elevation: 0,
        actions: [
          GetBuilder<UpdateInfoController>(
            builder: (updateInfoCtrl) {
              return TextButton(
                onPressed: () {
                  // if (keyForm.currentState!.validate()) {
                    updateInfoCtrl.updateUserInfo(
                      updateInfoCtrl.nameC.text,
                      updateInfoCtrl.bioC.text,
                      updateInfoCtrl.emailC.text,
                      updateInfoCtrl.addressC.text,
                      updateInfoCtrl.phoneC.text,
                      updateInfoCtrl.photoFile,
                      updateInfoCtrl.backgroundImageFile,
                    );
                  // }
                },
                child: TextCustom(
                  text: 'save',
                  fontSize: 14,
                  color: colorPrimary,
                ),
              );
            },
          ),
        ],
      ),
      body: GetBuilder<UpdateInfoController>(builder: (updateInfoCtrl) {
        return ListView(
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.size10),
              child: Column(
                children: [
                  buildEdit(
                    'udpate_photo'.tr,
                    () => buildBottomsheet(updateInfoCtrl, true),
                  ),
                  SizedBox(height: Dimensions.size20),
                  updateInfoCtrl.photoFile != null
                      ? GestureDetector(
                          onTap: () => buildBottomsheet(updateInfoCtrl, true),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: FileImage(
                              updateInfoCtrl.photoFile!,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => buildBottomsheet(updateInfoCtrl, true),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage(
                              AppGet.authGet.userData!.photo,
                            ),
                          ),
                        ),
                  const Divider(height: 40.0),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.size10),
              child: Column(
                children: [
                  buildEdit(
                    'update_background_image'.tr,
                    () => buildBottomsheet(updateInfoCtrl, false),
                  ),
                  SizedBox(height: Dimensions.size20),
                  GestureDetector(
                    onTap: () => buildBottomsheet(updateInfoCtrl, false),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        image: updateInfoCtrl.backgroundImageFile != null
                            ? DecorationImage(
                                image: FileImage(
                                  updateInfoCtrl.backgroundImageFile!,
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: NetworkImage(
                                  AppGet.authGet.userData!.backgroundImage,
                                ),
                                fit: BoxFit.cover,
                              ),
                        borderRadius: BorderRadius.circular(Dimensions.size5),
                      ),
                    ),
                  ),
                  const Divider(height: 40.0),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.size10),
              child: Column(
                children: [
                  buildEdit(
                    'the_bio'.tr,
                    () => AppNavigator.push(AppRoutes.updateInfoDetails),
                  ),
                  SizedBox(height: Dimensions.size20),
                  Center(
                    child: InkWell(
                      onTap: () => AppNavigator.push(AppRoutes.updateInfoDetails),
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.size5),
                        child: AppText(
                          'describe_yourself'.tr,
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 40.0),
                ],
              ),
            ),
            GetBuilder<AuthController>(builder: (authCtrl) {
              final AuthModel? userInfo = authCtrl.userData;
              return Container(
                padding: EdgeInsets.all(Dimensions.size10),
                child: Column(
                  children: [
                    buildEdit(
                      'details'.tr,
                      () => AppNavigator.push(AppRoutes.updateInfoDetails),
                    ),
                    SizedBox(height: Dimensions.size10),
                    userInfo!.address.isEmpty
                        ? buildDetails('current_residence'.tr, Icons.home)
                        : buildDetails(
                            "${"from".tr} ${userInfo.address}", Icons.link),
                    buildDetails('workplace'.tr, Icons.work_outline),
                    buildDetails('education'.tr, Icons.hail_outlined),
                    buildDetails('marital_status'.tr, Icons.heart_broken),
                    const Divider(height: 40.0),
                  ],
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}
