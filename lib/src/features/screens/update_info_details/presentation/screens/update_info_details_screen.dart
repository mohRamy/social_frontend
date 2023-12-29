import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';

import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../../../core/widgets/text_form_setting.dart';
import '../../../update_info/presentation/controllers/update_info_cotnroller.dart';

class UpdateInfoDetailsScreen extends GetView<UpdateInfoController> {
  const UpdateInfoDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppText('update_profile_details'.tr),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.size10),
            child: Form(
              key: keyForm,
              child: Column(
                children: [
                  SizedBox(height: Dimensions.size15),
                  TextFormSetting(
                      controller: controller.nameC,
                      labelText: 'User Name',
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'User required'),
                        MinLengthValidator(3,
                            errorText: 'Minimum of 3 characters')
                      ])),
                  SizedBox(height: Dimensions.size10),
                  TextFormSetting(
                    controller: controller.bioC,
                    labelText: 'Bio',
                    maxLines: 3,
                  ),
                  SizedBox(height: Dimensions.size15),
                  TextFormSetting(
                      controller: controller.emailC,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Nombre es requerido'),
                        MinLengthValidator(3, errorText: 'Minimo 3 caracteres')
                      ])),
                  SizedBox(height: Dimensions.size15),
                  TextFormSetting(
                    controller: controller.addressC,
                    // isReadOnly: true,
                    labelText: 'Address',
                  ),
                  SizedBox(height: Dimensions.size15),
                  TextFormSetting(
                    controller: controller.phoneC,
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
