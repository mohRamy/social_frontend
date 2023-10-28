import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/picker/picker.dart';
import '../../../../core/utils/app_component.dart';
import '../../../../public/components.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../../utils/sizer_custom/sizer.dart';
import '../components/painter_custom.dart';
import '../components/text_custom.dart';
import '../components/text_field_auth.dart';
import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? photo;

  void pickImageGallery() async {
    photo = await pickImageFromGallery();
    AppNavigator.pop;
    setState(() {});
  }

  void pickImageCamera() async {
    photo = await pickImageFromCamera();
    AppNavigator.pop;
    setState(() {});
  }

  void _registration(AuthController authCtrl) {
    String email = authCtrl.emailUC.text.trim();
    String password = authCtrl.passwordUC.text.trim();
    String name = authCtrl.nameUC.text.trim();

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
      setState(() {
        authCtrl.emailUC.text = "";
        authCtrl.passwordUC.text = "";
        authCtrl.nameUC.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authCtrl) {
        return SingleChildScrollView(
          child: Stack(
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
                            borderRadius:
                                BorderRadius.circular(Dimensions.size15),
                            color: Get.isDarkMode ? Colors.black : Colors.white,
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
                              AppComponents.buildbottomsheet(
                                  icon: Icon(
                                    Icons.camera,
                                    color: colorPrimary,
                                  ),
                                  label: "From camera",
                                  ontap: pickImageCamera),
                              Divider(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              AppComponents.buildbottomsheet(
                                  icon: Icon(
                                    Icons.photo,
                                    color: colorPrimary,
                                  ),
                                  label: "From Gallery",
                                  ontap: pickImageGallery),
                            ],
                          ),
                        ),
                      ),
                      elevation: 0.4,
                    );
                  },
                  child: photo != null
                      ? CircleAvatar(
                          radius: 65.sp,
                          backgroundColor: Colors.grey[700],
                          backgroundImage: FileImage(photo!),
                        )
                      : CircleAvatar(
                          radius: 65.sp,
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
                top: 320,
                child: TextFieldAuthCustom(
                  controller: authCtrl.nameUC,
                  label: 'Full Name',
                  isPass: false,
                ),
              ),
              Positioned(
                top: 390,
                child: TextFieldAuthCustom(
                  controller: authCtrl.emailUC,
                  label: 'Email',
                  isPass: false,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Positioned(
                top: 460,
                child: GetBuilder<AuthController>(builder: (authCtrl) {
                  return TextFieldAuthCustom(
                    controller: authCtrl.passwordUC,
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
                  );
                }),
              ),
              Positioned(
                top: 550,
                left: 15,
                child: TextButton(
                  onPressed: () => _registration(authCtrl),
                  child: CustomText(
                    text: 'Sign Up',
                    color: Colors.grey[700]!,
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
                    const CustomText(
                        text: 'Already have an account? ',
                        color: Colors.white,
                        fontSize: 17),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.login),
                      child: const CustomText(
                        text: 'Sign In',
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
