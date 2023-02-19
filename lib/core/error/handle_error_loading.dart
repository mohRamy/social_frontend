

import '../utils/app_component.dart';
import 'exceptions.dart';
import 'failures.dart';

class HandleErrorLoading {
  void handleError(Failure failure) {
    hideLoading();
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppComponent.showCustomSnackBar(failure.message);
      case EmptyCacheException:
        return AppComponent.showCustomSnackBar(failure.message);
      case OfflineFailure:
        return AppComponent.showCustomSnackBar("off line");
      default:
      return AppComponent.showCustomSnackBar("Unexpected Error , Please try again later .");
        
    }
  }

  showLoading([String? message]) {
    AppComponent.showLoading(message);
  }

  hideLoading() {
    AppComponent.hideLoading();
  }
}
