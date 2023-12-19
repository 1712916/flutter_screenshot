import 'dart:io';

import 'android_screenshot_listener.dart';
import 'ios_screenshot_listener.dart';

abstract class ScreenShotListener {
  ScreenShotListener();

  factory ScreenShotListener.getInstance() {
    if (Platform.isAndroid) {
      return AndroidScreenShotListener();
    } else if (Platform.isIOS) {
      return IOSScreenShotListener();
    }

    throw Exception("Unsupported");
  }

  void init();

  void addListener(Function(String path) callback);

  void dispose();
}
