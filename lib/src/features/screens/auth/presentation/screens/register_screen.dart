import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../public/components.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../components/painter_custom.dart';
import '../components/text_custom.dart';
import '../components/text_field_auth.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // File? photo;

  // void pickImageGallery() async {
  //   photo = await pickImageFromGallery();
  //   AppNavigator.pop();
  //   setState(() {});
  // }

  // void pickImageCamera() async {
  //   photo = await pickImageFromCamera();
  //   AppNavigator.pop();
  //   setState(() {});
  // }

  void _registration(AuthController authCtrl) {
    String name = authCtrl.nameRC.text.trim();
    String email = authCtrl.emailRC.text.trim();
    String password = authCtrl.passwordRC.text.trim();
    File? photo = authCtrl.photoFile;

    if (name.isEmpty) {
      Components.showSnackBar(
        'Type in your name',
        title: 'Name',
      );
    } else if (email.isEmpty) {
      Components.showSnackBar(
        'Type in your email address',
        title: 'Email address',
      );
    } else if (!GetUtils.isEmail(email)) {
      Components.showSnackBar(
        'Type in a valid email address',
        title: 'Valid email address',
      );
    } else if (password.isEmpty) {
      Components.showSnackBar(
        'Type in your password',
        title: 'password',
      );
    } else if (password.length < 6) {
      Components.showSnackBar(
        'Password can not less than six characters',
        title: 'password',
      );
    } else {
      authCtrl.register(
        name: name,
        email: email,
        password: password,
        photo: photo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (authCtrl) {
          return Stack(
            children: [
              const HeaderAuth(),
              const Positioned(
                top: 60,
                left: 20,
                child: CustomText(
                  text: 'Create an',
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Positioned(
                top: 110,
                left: 20,
                child: CustomText(
                  text: 'Account',
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const BottomRegister(),
              Positioned(
                top: 180,
                left: 0.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
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
                          height: 150.sp,
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
                                  Icons.camera,
                                  color: colorPrimary,
                                ),
                                label: "From camera",
                                ontap: () => authCtrl.selectImageFromCamera(),
                              ),
                              Divider(
                                color: Get.isDarkMode ? mCL : colorBlack,
                              ),
                              Components.buildbottomsheet(
                                icon: Icon(
                                  Icons.photo,
                                  color: colorPrimary,
                                ),
                                label: "From Gallery",
                                ontap: () => authCtrl.selectImageFromGallery(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 0.4,
                    );
                  },
                  child: authCtrl.photoFile != null
                      ? CircleAvatar(
                          radius: 60.sp,
                          backgroundColor: fCD,
                          backgroundImage: FileImage(authCtrl.photoFile!),
                        )
                      : CircleAvatar(
                          radius: 60.sp,
                          backgroundColor: Colors.grey.withOpacity(0.4),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black45,
                            size: 34.sp,
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 360,
                child: TextFieldAuthCustom(
                  controller: authCtrl.nameRC,
                  label: 'Full Name',
                  isPass: false,
                ),
              ),
              Positioned(
                top: 430,
                child: TextFieldAuthCustom(
                  controller: authCtrl.emailRC,
                  label: 'Email',
                  isPass: false,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Positioned(
                top: 500,
                child: TextFieldAuthCustom(
                  controller: authCtrl.passwordRC,
                  label: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      authCtrl.changeObsure();
                    },
                    child: Icon(
                      authCtrl.isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: colorPrimary,
                    ),
                  ),
                  isPass: authCtrl.isObscure,
                ),
              ),
              Positioned(
                top: 590,
                left: 15,
                child: TextButton(
                  onPressed: () => _registration(authCtrl),
                  child: CustomText(
                    text: 'Sign Up',
                    color: fCD,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 760,
                left: 15,
                child: Row(
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: mCL,
                          ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.login),
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: mCL,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
