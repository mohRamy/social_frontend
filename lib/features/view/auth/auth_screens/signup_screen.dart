import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../auth_ctrl/auth_ctrl.dart';
import '../auth_widgets/painter_custom.dart';
import '../auth_widgets/text_custom.dart';

import '../../../../core/picker/picker.dart';
import '../../../../core/utils/components/components.dart';
import '../../../../core/widgets/custom_loader.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthCtrl authCtrl = Get.find<AuthCtrl>();
  File? photo;

  void _registration(AuthCtrl authCtrl) {
    String email = authCtrl.emailUC.text.trim();
    String password = authCtrl.passwordUC.text.trim();
    String name = authCtrl.nameUC.text.trim();

    if (email.isEmpty) {
      Components.showCustomSnackBar(
        'Type in your email address',
        title: 'Email address',
      );
    } else if (!GetUtils.isEmail(email)) {
      Components.showCustomSnackBar(
        'Type in a valid email address',
        title: 'Valid email address',
      );
    } else if (password.isEmpty) {
      Components.showCustomSnackBar(
        'Type in your password',
        title: 'password',
      );
    } else if (password.length < 6) {
      Components.showCustomSnackBar(
        'Password can not less than six characters',
        title: 'password',
      );
    } else if (name.isEmpty) {
      Components.showCustomSnackBar(
        'Type in your name',
        title: 'Name',
      );
    } else {
      authCtrl.signUpUser(
        name: name,
        email: email,
        password: password,
        photo: photo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlackColor,
      body: GetBuilder<AuthCtrl>(builder: (authCtrl) {
        return !authCtrl.isLoading
            ? SingleChildScrollView(
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
                          
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Choose from that:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              photo =
                                                  await pickImageFromCamera();
                                              Get.back();
                                              setState(() {});
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white24,
                                                        width: 1),
                                                  ),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Dimensions.height10,
                                                ),
                                                const Text('Camera'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width30,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              photo =
                                                  await pickImageFromGallery();
                                              Get.back();
                                              setState(() {});
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white24,
                                                        width: 1),
                                                  ),
                                                  child: Icon(
                                                    Icons.photo,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text("Gallery"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ));
                        },
                        child: photo != null
                            ? CircleAvatar(
                                radius: Dimensions.radius45 + 20,
                                backgroundColor: Colors.white60,
                                backgroundImage: FileImage(photo!),
                              )
                            : CircleAvatar(
                                radius: Dimensions.radius45 + 20,
                                backgroundColor: Colors.white60,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.black45,
                                  size: Dimensions.iconSize24,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 320,
                      child: _TextFieldCustom(
                        controller: authCtrl.nameUC,
                        label: 'Full Name',
                        isPass: false,
                      ),
                    ),
                    Positioned(
                      top: 390,
                      child: _TextFieldCustom(
                        controller: authCtrl.emailUC,
                        label: 'Email',
                        isPass: false,
                      ),
                    ),
                    Positioned(
                      top: 460,
                      child: _TextFieldCustom(
                        controller: authCtrl.passwordUC,
                        label: 'Password',
                        isPass: true,
                      ),
                    ),
                    Positioned(
                      top: 550,
                      left: 15,
                      child: TextButton(
                        onPressed: () => _registration(authCtrl),
                        child: const CustomText(
                          text: 'Sign Up',
                          color: Colors.white,
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
                                Navigator.pushNamed(context, Routes.SIGN_IN),
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
              )
            : const CustomLoader();
      }),
    );
  }
}

class _TextFieldCustom extends StatelessWidget {
  final String label;
  final bool isPass;
  final TextEditingController controller;

  const _TextFieldCustom({
    Key? key,
    required this.label,
    required this.isPass,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: Dimensions.screenWidth * 0.9,
        child: TextField(
          controller: controller,
          obscureText: isPass,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
