import 'dart:async';

import 'package:get/get.dart';
import 'package:social_app/src/resources/local/user_local.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../public/components.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../screens/privacy/domain/usecases/private_account.dart';

class PrivacyController extends GetxController with HandleLoading {
  final PrivateAccountUseCase privateAccountUseCase;
  PrivacyController(
    this.privateAccountUseCase,
  );

  bool isPrivate = false;

  @override
  void onInit() {
    isPrivate = UserLocal().getUser()?.private??false;
    super.onInit();
  }

  FutureOr<void> privateAccount() async {
    isPrivate = !isPrivate;
    update();
    showLoading();
    final result = await privateAccountUseCase();
    result.fold((l) => handleLoading(l), (r) {
      hideLoading();
      update();
      Components.showSnackBar(
        "Your Account Private!",
        title: "Private",
        color: colorPrimary,
      );
    });
    hideLoading();
    update();
  }
}
