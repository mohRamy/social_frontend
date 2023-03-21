

import '../utils/app_component.dart';
import 'exceptions.dart';
import 'failures.dart';

class HandleErrorLoading {
  void handleError(Failure failure) {
    hideLoading();
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppComponents.showCustomSnackBar(failure.message);
      case EmptyCacheException:
        return AppComponents.showCustomSnackBar(failure.message);
      case OfflineFailure:
        return AppComponents.showCustomSnackBar("off line");
      default:
      return AppComponents.showCustomSnackBar("Unexpected Error , Please try again later .");
        
    }
  }

  showLoading([String? message]) {
    AppComponents.showLoading(message);
  }

  hideLoading() {
    AppComponents.hideLoading();
  }
}
