import 'dart:io';

class PlatformUtils {

  PlatformUtils._();

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }
}