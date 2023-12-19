import 'package:screen_capture_event/screen_capture_event.dart';

import 'screenshot_listener.dart';

class AndroidScreenShotListener extends ScreenShotListener {
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();

  @override
  void init() {
    screenListener.watch();
  }

  @override
  void addListener(Function(String path) callback) {
    screenListener.addScreenShotListener(callback);
  }

  @override
  void dispose() {
    screenListener.dispose();
  }
}
