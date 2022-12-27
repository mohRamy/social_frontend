// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:social_app/features/post/post_ctrl/post_ctrl.dart';

// class AppPermission {

//   final ImagePicker _picker = ImagePicker();
//   final PostCtrl postCtrl = Get.find<PostCtrl>(); 


//   Future<void> permissionAccessGalleryOrCameraForCover(PermissionStatus status, BuildContext context, ImageSource source) async {

//     switch (status){
    
//       case PermissionStatus.granted:
//           final XFile? imagePath = await _picker.pickImage(source: source);
//           if( imagePath != null ){
//             postCtrl.imageFileSelected.add( File(imagePath.path) );
//             // BlocProvider.of<UserBloc>(context).add( OnUpdatePictureCover( imagePath.path ));
//           }
//         break;
//       case PermissionStatus.denied:
//       case PermissionStatus.restricted:
//       case PermissionStatus.limited:
//         break;
//       case PermissionStatus.permanentlyDenied:
//         openAppSettings();
//         break;
//     }
//   }


//   Future<void> permissionAccessGalleryOrCameraForProfile(PermissionStatus status, BuildContext context, ImageSource source) async {

//     switch (status){
    
//       case PermissionStatus.granted:
//           final XFile? imagePath = await _picker.pickImage(source: source);
//           if( imagePath != null ){
//             postCtrl.imageFileSelected.add( File(imagePath.path) );
//             // BlocProvider.of<UserBloc>(context).add( OnUpdatePictureProfile( imagePath.path ));
//           }
//         break;
//       case PermissionStatus.denied:
//       case PermissionStatus.restricted:
//       case PermissionStatus.limited:
//         break;
//       case PermissionStatus.permanentlyDenied:
//         openAppSettings();
//         break;
//     }
//   }


//   Future<void> permissionAccessGalleryOrCameraForNewPost(PermissionStatus status, BuildContext context, ImageSource source) async {

//     switch (status){
    
//       case PermissionStatus.granted:
//           final XFile? imagePath = await _picker.pickImage(source: source);
//           if( imagePath != null ){
//             postCtrl.imageFileSelected.add( File(imagePath.path) );
//             // BlocProvider.of<PostBloc>(context).add( OnSelectedImageEvent( File(imagePath.path) ));
//           }
//         break;
//       case PermissionStatus.denied:
//       case PermissionStatus.restricted:
//       case PermissionStatus.limited:
//         break;
//       case PermissionStatus.permanentlyDenied:
//         openAppSettings();
//         break;
//     }
//   }
  
  
//   Future<void> permissionAccessGalleryMultiplesImagesNewPost(PermissionStatus status, BuildContext context) async {

//     switch (status){
    
//       case PermissionStatus.granted:
//           final List<XFile?>? imagePath = await _picker.pickMultiImage();
//           if( imagePath != null ){
//             for (var image in imagePath) { 
//               postCtrl.imageFileSelected.add( File(image!.path) );
//               // BlocProvider.of<PostBloc>(context).add( OnSelectedImageEvent( File(image!.path) ));
//             }
//           }
//         break;
//       case PermissionStatus.denied:
//       case PermissionStatus.restricted:
//       case PermissionStatus.limited:
//         break;
//       case PermissionStatus.permanentlyDenied:
//         openAppSettings();
//         break;
//     }
//   }




// }