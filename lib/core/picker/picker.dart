import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../utils/components/components.dart';

Future<File?> pickImageFromGallery() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Components.showCustomSnackBar(e.toString());
  }
  return image;
}

Future<File?> pickImageFromCamera() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    Components.showCustomSnackBar(e.toString());
  }
  return image;
}

Future<File?> pickVideoFromGallery() async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    Components.showCustomSnackBar(e.toString());
  }
  return video;
}

Future<File?> pickVideoFromCamera() async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.camera);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    Components.showCustomSnackBar(e.toString());
  }
  return video;
}
