import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/themes/app_colors.dart';
import '../../../../public/components.dart';
import '../../../../routes/app_pages.dart';
import '../controller/auth_controller.dart';

import '../components/painter_custom.dart';
import '../components/text_custom.dart';
import '../components/text_field_auth.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void login() {
      String email = controller.emailIC.text.trim();
      String password = controller.passwordIC.text.trim();

      if (email.isEmpty) {
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
        controller.login(email, password);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const HeaderAuth(),
            const Positioned(
                top: 60,
                left: 20,
                child: CustomText(
                    text: 'Welcome',
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            const Positioned(
                top: 110,
                left: 20,
                child: CustomText(
                    text: 'Back',
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            const BottomAuth(),
            Positioned(
              top: 270,
              child: TextFieldAuthCustom(
                controller: controller.emailIC,
                label: 'Email',
                isPass: false,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Positioned(
              top: 340,
              child: GetBuilder<AuthController>(
                builder: (authCtrl) {
                return TextFieldAuthCustom(
                  controller: controller.passwordIC,
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
            const Positioned(
              top: 420,
              left: 15,
              child: CustomText(
                text: 'Forgot Password?',
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Positioned(
              top: 460,
              left: 15,
              child: TextButton(
                onPressed: () => login(),
                child: CustomText(
                  text: 'Sign In',
                  color: Colors.grey[700]!,
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
                        text: 'Don\'t have an account? ',
                        color: Colors.white,
                        fontSize: 17),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                      child: const CustomText(
                        text: 'Sign Up',
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
