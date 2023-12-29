import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/app_text.dart';
import '../controllers/update_post_controller.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../../../core/widgets/text_form_setting.dart';
import '../../../../taps/home/data/models/post_model.dart';

class UpdatePostScreen extends GetView<UpdatePostController> {
  final PostModel post;
  const UpdatePostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const AppText('modify Post'),
        elevation: 0,
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              AppNavigator.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
        actions: [
          GetBuilder<UpdatePostController>(builder: (updatePostCtrl) {
            updatePostCtrl.initTextCtrl(post.description);
            return TextButton(
              onPressed: () {
                if (keyForm.currentState!.validate()) {
                  updatePostCtrl.udpatePost(
                    post.id,
                    updatePostCtrl.descriptionC.text.trim(),
                  );
                }
              },
              child: const AppText(
                'save',
                type: TextType.medium,
              ),
            );
          })
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.size10),
            child: Form(
              key: keyForm,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  TextFormSetting(
                    controller: controller.descriptionC,
                    labelText: 'description',
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
