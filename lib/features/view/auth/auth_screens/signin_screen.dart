import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/view/auth/auth_widgets/text_field_auth.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../auth_ctrl/auth_ctrl.dart';
import '../auth_widgets/painter_custom.dart';
import '../auth_widgets/text_custom.dart';

class SignInScreen extends GetView<AuthCtrl> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _login(AuthCtrl authCtrl) {
      String email = controller.emailIC.text.trim();
      String password = controller.passwordIC.text.trim();

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
      } else {
        authCtrl.signInUser(email, password);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                      child: GetBuilder<AuthCtrl>(
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
                                  color: AppColors.primary,
                                ),
                              ),
                            isPass: authCtrl.isObscure,
                          );
                        }
                      ),
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
                        onPressed: () => _login(authCtrl),
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
                              onTap: () =>
                                  Navigator.pushNamed(context, Routes.SIGN_UP),
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
              )
            : const CustomLoader(),
      ),
    );
  }
}

