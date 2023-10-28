

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/public/components.dart';

import '../utils/app_component.dart';
import 'exceptions.dart';
import 'failures.dart';

class HandleErrorLoading {
  void handleError(Failure failure) {
    hideLoading();
    switch (failure.runtimeType) {
      case ServerFailure:
        return Components.showSnackBar(failure.message, title: "Server Failure");
      case EmptyCacheException:
        return Components.showSnackBar(failure.message, title: "Empty Cache Failure");
      case OfflineFailure:
        return Components.showSnackBar("Offline Failure", snackPosition: SnackPosition.BOTTOM, color: Colors.white10.withOpacity(0.6));
      default:
      return Components.showSnackBar("Unexpected Error , Please try again later .");
    }
  }

  showLoading([String? message]) {
    AppComponents.showLoading(message);
  }

  hideLoading() {
    AppComponents.hideLoading();
  }
}
