import '../config/application.dart';

class ApplicationController {
  Stream onSetupApplication() async* {
    await Application().initialAppLication();
  }
}
