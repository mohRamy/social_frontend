import 'package:flutter/material.dart'; 
import 'package:get/get.dart';

import 'package:social_app/config/routes/app_pages.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/dimensions.dart';
import 'package:social_app/features/auth/auth_ctrl/auth_ctrl.dart';
import 'package:social_app/features/auth/auth_widgets/painter_custom.dart';
import 'package:social_app/features/auth/auth_widgets/text_custom.dart';

import '../../../core/utils/components/components.dart';
import '../../../core/widgets/custom_loader.dart';

class SignUpScreen extends GetView<AuthCtrl> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _registration(AuthCtrl authCtrl) {
      String email = controller.emailUC.text.trim();
      String password = controller.passwordUC.text.trim();
      String name = controller.nameUC.text.trim();

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
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.bgBlackColor,
      body: GetBuilder<AuthCtrl>(
        builder: (authCtrl) => !authCtrl.isLoading
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
                      top: 250,
                      child: _TextFieldCustom(
                        controller: controller.nameUC,
                        label: 'Full Name',
                        isPass: false,
                      ),
                    ),
                    Positioned(
                      top: 320,
                      child: _TextFieldCustom(
                        controller: controller.emailUC,
                        label: 'Email',
                        isPass: false,
                      ),
                    ),
                    Positioned(
                      top: 390,
                      child: _TextFieldCustom(
                        controller: controller.passwordUC,
                        label: 'Password',
                        isPass: true,
                      ),
                    ),
                    Positioned(
                      top: 480,
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
                      top: 720,
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
            : const CustomLoader(),
      ),
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
