import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../public/components.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../controllers/auth_controller.dart';

import '../components/painter_custom.dart';
import '../components/text_custom.dart';
import '../components/text_field_auth.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void login() {
      String email = controller.emailLC.text.trim();
      String password = controller.passwordLC.text.trim();

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
                controller: controller.emailLC,
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
                  controller: controller.passwordLC,
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
                  color: fCD,
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
                    Text(
                        'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: mCL,
                            ),
                      ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: mCL,
                            ),
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
