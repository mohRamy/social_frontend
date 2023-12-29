import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/routes/app_pages.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../public/components.dart';
import '../../../../../themes/app_colors.dart';
import '../../domain/usecases/change_password.dart';

class ChangePasswordController extends GetxController with HandleLoading {
  final ChangepasswordUseCase changepasswordUseCase;
  ChangePasswordController(
    this.changepasswordUseCase,
  );

  late TextEditingController currentPasswordC;
  late TextEditingController newPasswordC;
  late TextEditingController newPasswordAgainC;

  @override
  void onInit() {
    currentPasswordC = TextEditingController();
    newPasswordC = TextEditingController();
    newPasswordAgainC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    currentPasswordC.dispose();
    newPasswordC.dispose();
    newPasswordAgainC.dispose();
    super.dispose();
  }

  FutureOr<void> changepassword(
    String currentPassword,
    String newPassword,
  ) async {
    showLoading();
    final result = await changepasswordUseCase(currentPassword, newPassword);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        clearTextCtrl();
        hideLoading();
        update();
        Components.showSnackBar(
          "Your Password Changed!",
          title: "Security",
          color: colorPrimary,
        );
        AppNavigator.pop();
      },
    );
    hideLoading();
    update();
  }

  void clearTextCtrl() {
    currentPasswordC.clear();
    newPasswordC.clear();
    newPasswordAgainC.clear();
    update();
  }
}
