// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:social_app/features/view/auth/auth_screens/signin_screen.dart';

// import '../../../../config/routes/app_pages.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/dimensions.dart';
// import '../auth_ctrl/auth_ctrl.dart';
// import '../auth_widgets/painter_custom.dart';
// import '../auth_widgets/text_custom.dart';

// import '../../../../core/picker/picker.dart';
// import '../../../../core/utils/app_component.dart';
// import '../../../../core/widgets/custom_loader.dart';
// import '../auth_widgets/text_field_auth.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   AuthCtrl authCtrl = Get.find<AuthCtrl>();
//   File? photo;

//   void pickImageGallery() async {
//     photo = await pickImageFromGallery();
//     Get.back();
//     setState(() {});
//   }

//   void pickImageCamera() async {
//     photo = await pickImageFromCamera();
//     Get.back();
//     setState(() {});
//   }

//   void _registration(AuthCtrl authCtrl) {
//     String email = authCtrl.emailUC.text.trim();
//     String password = authCtrl.passwordUC.text.trim();
//     String name = authCtrl.nameUC.text.trim();

//     if (email.isEmpty) {
//       AppComponent.showCustomSnackBar(
//         'Type in your email address',
//         title: 'Email address',
//       );
//     } else if (!GetUtils.isEmail(email)) {
//       AppComponent.showCustomSnackBar(
//         'Type in a valid email address',
//         title: 'Valid email address',
//       );
//     } else if (password.isEmpty) {
//       AppComponent.showCustomSnackBar(
//         'Type in your password',
//         title: 'password',
//       );
//     } else if (password.length < 6) {
//       AppComponent.showCustomSnackBar(
//         'Password can not less than six characters',
//         title: 'password',
//       );
//     } else if (name.isEmpty) {
//       AppComponent.showCustomSnackBar(
//         'Type in your name',
//         title: 'Name',
//       );
//     } else {
//       authCtrl.signUpUser(
//         name: name,
//         email: email,
//         password: password,
//         photo: photo,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: GetBuilder<AuthCtrl>(builder: (authCtrl) {
//         return !authCtrl.isLoading
//             ? SingleChildScrollView(
//                 child: Stack(
//                   children: [
//                     const HeaderAuth(),
//                     const Positioned(
//                       top: 60,
//                       left: 20,
//                       child: CustomText(
//                         text: 'Create an',
//                         color: Colors.white,
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Positioned(
//                       top: 110,
//                       left: 20,
//                       child: CustomText(
//                         text: 'Account',
//                         color: Colors.white,
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const BottomRegister(),
//                     Positioned(
//                       top: 180,
//                       left: 0.0,
//                       right: 0.0,
//                       child: GestureDetector(
//                         onTap: () {
//                           Get.bottomSheet(
//                             SingleChildScrollView(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                       Dimensions.radius15),
//                                   color: Get.isDarkMode
//                                       ? Colors.black
//                                       : Colors.white,
//                                 ),
//                                 padding: const EdgeInsetsDirectional.only(
//                                   top: 4,
//                                 ),
//                                 width: Dimensions.screenWidth,
//                                 height: Dimensions.height10 * 15,
//                                 child: Column(
//                                   children: [
//                                     Flexible(
//                                       child: Container(
//                                         height: 6,
//                                         width: 120,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           color: Get.isDarkMode
//                                               ? Colors.grey[600]
//                                               : Colors.grey[300],
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     AppComponent.buildbottomsheet(
//                                       icon: Icon(
//                                         Icons.camera,
//                                         color: AppColors.primary,
//                                       ),
//                                       label: "From camera",
//                                       ontap: pickImageCamera
//                                     ),
//                                     Divider(
//                                       color: Get.isDarkMode
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                     AppComponent.buildbottomsheet(
//                                       icon: Icon(
//                                         Icons.photo,
//                                         color: AppColors.primary,
//                                       ),
//                                       label: "From Gallery",
//                                       ontap: pickImageGallery
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             elevation: 0.4,
//                           );
//                         },
//                         child: photo != null
//                             ? CircleAvatar(
//                                 radius: Dimensions.radius45 + 20,
//                                 backgroundColor: Colors.grey[700],
//                                 backgroundImage: FileImage(photo!),
//                               )
//                             : CircleAvatar(
//                                 radius: Dimensions.radius45 + 20,
//                                 backgroundColor: Colors.grey.withOpacity(0.4),
//                                 child: Icon(
//                                   Icons.camera_alt_rounded,
//                                   color: Colors.black45,
//                                   size: Dimensions.iconSize24 + 10,
//                                 ),
//                               ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 320,
//                       child: TextFieldAuthCustom(
//                         controller: authCtrl.nameUC,
//                         label: 'Full Name',
//                         isPass: false,
//                       ),
//                     ),
//                     Positioned(
//                       top: 390,
//                       child: TextFieldAuthCustom(
//                         controller: authCtrl.emailUC,
//                         label: 'Email',
//                         isPass: false,
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                     ),
//                     Positioned(
//                       top: 460,
//                       child: GetBuilder<AuthCtrl>(builder: (authCtrl) {
//                         return TextFieldAuthCustom(
//                           controller: authCtrl.passwordUC,
//                           label: 'Password',
//                           suffixIcon: GestureDetector(
//                             onTap: () {
//                               authCtrl.changeObsure();
//                             },
//                             child: Icon(
//                               authCtrl.isObscure
//                                   ? Icons.visibility_outlined
//                                   : Icons.visibility_off_outlined,
//                               color: AppColors.primary,
//                             ),
//                           ),
//                           isPass: authCtrl.isObscure,
//                         );
//                       }),
//                     ),
//                     Positioned(
//                       top: 550,
//                       left: 15,
//                       child: TextButton(
//                         onPressed: () => _registration(authCtrl),
//                         child: CustomText(
//                           text: 'Sign Up',
//                           color: Colors.grey[700]!,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 760,
//                       left: 15,
//                       child: Row(
//                         children: [
//                           const CustomText(
//                               text: 'Already have an account? ',
//                               color: Colors.white,
//                               fontSize: 17),
//                           GestureDetector(
//                             onTap: () =>
//                                 Navigator.pushNamed(context, Routes.SIGN_IN),
//                             child: const CustomText(
//                               text: 'Sign In',
//                               color: Colors.white,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : const CustomLoader();
//       }),
//     );
//   }
// }
