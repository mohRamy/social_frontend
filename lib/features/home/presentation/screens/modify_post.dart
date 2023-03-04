import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../profile/presentation/components/text_form_profile.dart';
import '../../domain/entities/post.dart';
import '../controller/home_controller.dart';

class ModifyPostScreen extends StatefulWidget {
  const ModifyPostScreen({Key? key}) : super(key: key);

  @override
  State<ModifyPostScreen> createState() => _ModifyPostScreenState();
}

class _ModifyPostScreenState extends State<ModifyPostScreen> {
  late TextEditingController _descC;
  final _keyForm = GlobalKey<FormState>();

  final Post postData = Get.arguments;

  @override
  void initState() {
    _descC = TextEditingController(text: postData.description);
    super.initState();
  }

  @override
  void dispose() {
    _descC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TextCustom(text: 'modify Post', fontSize: 19),
        elevation: 0,
        leading: IconButton(
            splashRadius: 20,
            onPressed: () { 
              Get.back();
              Get.back();
              },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
        actions: [
          GetBuilder<HomeController>(
            builder: (homeCtrl) {
              return TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    homeCtrl.modifyPost(
                      postData.id,
                      _descC.text.trim(),
                    );
                    Get.back();
                    Get.back();
                  }
                },
                child: const TextCustom(
                  text: 'save',
                  fontSize: 14,
                ),
              );
            }
          )
        ],
      ),
      body: ListView(
        children: [
    Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  TextFormProfile(
                    controller: _descC,
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
