

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../public/components.dart';
import 'exceptions.dart';
import 'failures.dart';

class HandleLoading {
  void handleLoading(Failure failure) {
    hideLoading();
    switch (failure.runtimeType) {
      case ServerFailure:
        return Components.showSnackBar(failure.message, title: "Server Failure");
      case LocalException:
        return Components.showSnackBar(failure.message, title: "Empty Cache Failure");
      case OfflineFailure:
        return Components.showSnackBar("Offline Failure", snackPosition: SnackPosition.BOTTOM, color: Colors.white10.withOpacity(0.6));
      default:
      return Components.showSnackBar("Unexpected Error , Please try again later .");
    }
  }

  showLoading([String? message]) {
    Components.showLoading(message);
  }

  hideLoading() {
    Components.hideLoading();
  }
}
