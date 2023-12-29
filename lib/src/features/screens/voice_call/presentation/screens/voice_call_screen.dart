import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_app/src/features/screens/voice_call/index.dart';
import 'package:social_app/src/themes/app_colors.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';

class VoiceCallScreen extends GetView<VoiceCallController> {
  final String name;
  final String avatar;
  const VoiceCallScreen({
    Key? key,
    required this.name,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              Positioned(
                top: Dimensions.size10,
                left: Dimensions.size30,
                right: Dimensions.size30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      controller.callTime.value,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: mCL,
                          ),
                    ),
                    Container(
                      width: 70.h,
                      height: 70.h,
                      margin: EdgeInsets.only(top: 150.h),
                      child: Image.network(avatar),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: mCL,
                              fontSize: 18.sp,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 80.h,
                left: 30.w,
                right: 30.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(15.w),
                            width: 60.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.w),
                              ),
                              color:
                                  controller.openMicrophone.value ? mCL : fCD,
                            ),
                            child: controller.openMicrophone.value
                                ? Image.asset(
                                    "assets/icons/b_microphone.png",
                                  )
                                : Image.asset(
                                    "assets/icons/a_microphone.png",
                                  ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(Dimensions.size10),
                          child: Text(
                            'Microphone',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: mCL,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(15.w),
                            width: 60.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.w),
                              ),
                              color:
                                  controller.isJoined.value ? mCL : fCD,
                            ),
                            child: controller.isJoined.value
                                ? Image.asset(
                                    "assets/icons/a_phone.png",
                                  )
                                : Image.asset(
                                    "assets/icons/a_telephone.png",
                                  ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(Dimensions.size10),
                          child: Text(
                            controller.isJoined.value
                            ? 'Disconnet'
                            : "Connect",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: mCL,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(15.w),
                            width: 60.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.w),
                              ),
                              color:
                                  controller.enableSpeaker.value ? mCL : fCD,
                            ),
                            child: controller.enableSpeaker.value
                                ? Image.asset(
                                    "assets/icons/b_trunpet.png",
                                  )
                                : Image.asset(
                                    "assets/icons/a_trunpet.png",
                                  ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(Dimensions.size10),
                          child: Text(
                            'Speacker',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: mCL,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
