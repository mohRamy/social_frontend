import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';

import '../../../../../core/widgets/app_text.dart';
import '../../../../../lang/language_service.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/font_family.dart';
import '../components/language_widget.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const AppText('Language'),
        elevation: 0,
      ),
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
            builder: (localizationController) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: SizedBox(
                          width: Dimensions.screenWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Center(
                              //   child: Image.asset(
                              //     AppConstants.LOGO64_ASSET,
                              //     width: 120,
                              //   ),
                              // ),
                              const SizedBox(height: 5),
                              Center(
                                child: Text(
                                  'The Best Food',
                                  style: TextStyle(
                                    color: colorPrimary,
                                    fontFamily: FontFamily.allison,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: AppText('select_language'.tr),
                              ),
                              const SizedBox(height: 10),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemCount: 2,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                  LanguageWidget(
                                    languageModel:
                                        localizationController.languages[index],
                                    localizationController:
                                        localizationController,
                                    index: index,
                                  ),
                              ),
                              const SizedBox(height: 10),
                              AppText('you_can_change_language'.tr),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
