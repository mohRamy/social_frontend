import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../core/widgets/app_text.dart';
import '../../routes/app_pages.dart';
import '../../utils/sizer_custom/sizer.dart';

class CustomImagePicker {
  final _picker = ImagePicker();

  Widget _buildImageModalButton(
      {context, index, icon, text, source, Function? handleFinish}) {
    return TextButton(
      onPressed: () async {
        XFile? image = await getImage(
          context: context,
          source: source,
          maxWidthImage: 600,
        );
        AppNavigator.pop();
        if (image != null && handleFinish != null) {
          handleFinish(File(image.path));
        }
      },
      style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 0),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black.withOpacity(0.5);
              }
              return Colors.black;
            },
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.sp),
        child: Row(
          children: [
            Icon(
              icon,
              size: 21.25.sp,
            ),
            SizedBox(
              width: 15.sp,
            ),
            AppText(
              text,
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(
      {context,
      source = ImageSource.gallery,
      maxWidthImage,
      imageQualityImage}) async {
    return await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1000,
    );
  }

  Future openImagePicker({
    @required context,
    text = 'Select avatar',
    Function? handleFinish,
  }) {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        height: 170.sp,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.sp,
            ),
            AppText(
              text,
            ),
            SizedBox(
              height: 10.sp,
            ),
            _buildImageModalButton(
              context: context,
              index: 0,
              icon: PhosphorIcons.instagramLogo,
              text: 'From Gallery',
              source: ImageSource.gallery,
              handleFinish: handleFinish,
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
              color: Color(0xffe5e5e5),
            ),
            _buildImageModalButton(
              context: context,
              index: 1,
              icon: PhosphorIcons.camera,
              text: 'From Camera',
              source: ImageSource.camera,
              handleFinish: handleFinish,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
