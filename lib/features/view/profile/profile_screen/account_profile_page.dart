import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:social_app/features/auth/domain/entities/auth.dart';
import '../../../../core/picker/picker.dart';
import '../../../../core/utils/app_component.dart';
import '../../../../core/utils/dimensions.dart';
import '../profile_ctrl/profile_ctrl.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/widgets/widgets.dart';
import '../profile_widgets/text_form_profile.dart';

class AccountProfilePage extends StatefulWidget {
  const AccountProfilePage({Key? key}) : super(key: key);

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  late TextEditingController _nameC;
  late TextEditingController _bioC;
  late TextEditingController _emailC;
  late TextEditingController _addressC;
  late TextEditingController _phoneC;
  final _keyForm = GlobalKey<FormState>();

  final Auth userData = Get.arguments;

  File? image;

  void pickImageGallery() async {
    image = await pickImageFromGallery();
    Get.back();
    setState(() {});
  }

  void pickImageCamera() async {
    image = await pickImageFromCamera();
    Get.back();
    setState(() {});
  }

  File? imageP;

  void pickImageGalleryP() async {
    imageP = await pickImageFromGallery();
    Get.back();
    setState(() {});
  }

  void pickImageCameraP() async {
    imageP = await pickImageFromCamera();
    Get.back();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _nameC = TextEditingController(text: userData.name);
    _bioC = TextEditingController(text: userData.bio);
    _emailC = TextEditingController(text: userData.email);
    _addressC = TextEditingController(text: userData.address);
    _phoneC = TextEditingController(text: userData.phone);
  }

  @override
  void dispose() {
    _nameC.dispose();
    _bioC.dispose();
    _emailC.dispose();
    _addressC.dispose();
    _phoneC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TextCustom(text: 'modify Profile', fontSize: 19),
        elevation: 0,
        // leading: IconButton(
        //   highlightColor: Colors.transparent,
        //   onPressed: () => Get.back(),
        //   icon:
        //       const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        // ),
        actions: [
          TextButton(
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                Get.find<ProfileCtrl>().modifyUserData(
                  _nameC.text,
                  _bioC.text,
                  _emailC.text,
                  _addressC.text,
                  _phoneC.text,
                  imageP,
                  image,
                );
              }
            },
            child: const TextCustom(
              text: 'save',
              fontSize: 14,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                Container(
                  height: 170,
                  width: Dimensions.screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.7),
                  ),
                  child: image != null
                      ? Image.file(image!, fit: BoxFit.cover)
                      : userData.backgroundImage.isNotEmpty
                          ? Image.network(
                              userData.backgroundImage,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXYE2NzC7cY66U6JRENpM0eVXn9JyOUJ5PVQ&usqp=CAU',
                              fit: BoxFit.cover,
                            ),
                ),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                          ),
                          padding: const EdgeInsetsDirectional.only(
                            top: 4,
                          ),
                          width: Dimensions.screenWidth,
                          height: Dimensions.height10 * 15,
                          child: Column(
                            children: [
                              Flexible(
                                child: Container(
                                  height: 6,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Get.isDarkMode
                                        ? Colors.grey[600]
                                        : Colors.grey[300],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppComponent.buildbottomsheet(
                                icon: Icon(
                                  Icons.camera,
                                  color: AppColors.primary,
                                ),
                                label: "From camera",
                                ontap: pickImageCamera,
                              ),
                              Divider(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              AppComponent.buildbottomsheet(
                                icon: Icon(
                                  Icons.photo,
                                  color: AppColors.primary,
                                ),
                                label: "From Gallery",
                                ontap: pickImageGallery,
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 0.4,
                    );
                  },
                  child: Container(
                    height: 170,
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.5),
                    child: Icon(Icons.camera_alt_outlined,
                        size: Dimensions.iconSize24 + 15, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 28,
                  child: Container(
                    height: Dimensions.height20,
                    width: Dimensions.screenWidth,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? AppColors.bgDarkColor
                            : AppColors.bgLightColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20.0))),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: Dimensions.width30,
                  child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      // width: size.width,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Get.bottomSheet(
                      SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                          ),
                          padding: const EdgeInsetsDirectional.only(
                            top: 4,
                          ),
                          width: Dimensions.screenWidth,
                          height: Dimensions.height10 * 15,
                          child: Column(
                            children: [
                              Flexible(
                                child: Container(
                                  height: 6,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Get.isDarkMode
                                        ? Colors.grey[600]
                                        : Colors.grey[300],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppComponent.buildbottomsheet(
                                icon: Icon(
                                  Icons.camera,
                                  color: AppColors.primary,
                                ),
                                label: "From camera",
                                ontap: pickImageCameraP,
                              ),
                              Divider(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              AppComponent.buildbottomsheet(
                                icon: Icon(
                                  Icons.photo,
                                  color: AppColors.primary,
                                ),
                                label: "From Gallery",
                                ontap: pickImageGalleryP,
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 0.4,
                    );
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: imageP != null
                                        ? Image.file(imageP!, fit: BoxFit.cover)
                                        : Image.network(
                                            userData.photo,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(100),
                                //   child: imageP != null
                                //       ? Image.file(imageP!, fit: BoxFit.cover)
                                //       : Image.network(userData.photo, fit: BoxFit.cover),
                                // ),

                                CircleAvatar(
                                  radius: 100,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  child: Icon(Icons.camera_alt_outlined,
                                      size: Dimensions.iconSize24 + 10),
                                ),
                              ],
                            )),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  TextFormProfile(
                      controller: _nameC,
                      labelText: 'User Name',
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'User required'),
                        MinLengthValidator(3,
                            errorText: 'Minimum of 3 characters')
                      ])),
                  const SizedBox(height: 10.0),
                  TextFormProfile(
                    controller: _bioC,
                    labelText: 'Bio',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormProfile(
                      controller: _emailC,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Nombre es requerido'),
                        MinLengthValidator(3, errorText: 'Minimo 3 caracteres')
                      ])),
                  const SizedBox(height: 20.0),
                  TextFormProfile(
                    controller: _addressC,
                    isReadOnly: true,
                    labelText: 'Address',
                  ),
                  const SizedBox(height: 20.0),
                  TextFormProfile(
                    controller: _phoneC,
                    labelText: 'phone',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
