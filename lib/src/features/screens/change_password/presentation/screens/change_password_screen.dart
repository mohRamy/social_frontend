import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/app_text.dart';
import '../controllers/change_password_controller.dart';
import '../../../../../utils/sizer_custom/sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../core/widgets/text_form_setting.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyForm = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const AppText('Password'),
          elevation: 0,
          actions: [
            GetBuilder<ChangePasswordController>(builder: (changePasswordCtrl) {
              return TextButton(
                onPressed: () {
                  if (keyForm.currentState!.validate()) {
                    changePasswordCtrl.changepassword(
                      controller.currentPasswordC.text.trim(),
                      controller.newPasswordAgainC.text.trim(),
                    );
                  }
                },
                child: TextCustom(
                  text: 'Keep',
                  fontSize: Dimensions.size15,
                  color: colorPrimary,
                ),
              );
            })
          ],
        ),
        body: Form(
          key: keyForm,
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.size20,
              vertical: Dimensions.size10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormSetting(
                    controller: controller.currentPasswordC,
                    labelText: 'Current password',
                    validator: MultiValidator([
                      MinLengthValidator(6, errorText: 'Minimum 6 characters'),
                      RequiredValidator(errorText: 'The field cannot be empty')
                    ]),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormSetting(
                    controller: controller.newPasswordC,
                    labelText: 'New Password',
                    validator: MultiValidator([
                      MinLengthValidator(6, errorText: 'Minimum 6 characters'),
                      RequiredValidator(errorText: 'The field cannot be empty')
                    ]),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormSetting(
                    controller: controller.newPasswordAgainC,
                    labelText: 'Repeat password',
                    validator: MultiValidator([
                      MinLengthValidator(6, errorText: 'Minimum 6 characters'),
                      RequiredValidator(errorText: 'The field cannot be empty')
                    ]),
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}
