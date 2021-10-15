import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class DeviceType {
  // Syntax sugar, proxy the UniversalPlatform methods so our views can reference a single class
  static bool isIOS = UniversalPlatform.isIOS;
  static bool isAndroid = UniversalPlatform.isAndroid;
  static bool isMacOS = UniversalPlatform.isMacOS;
  static bool isLinux = UniversalPlatform.isLinux;
  static bool isWindows = UniversalPlatform.isWindows;

  // Higher level device class abstractions (more syntax sugar for the views)
  static bool isWeb = UniversalPlatform.isWeb;
  static bool get isDesktop => isWindows || isMacOS || isLinux;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktopOrWeb => isDesktop || isWeb;
  static bool get isMobileOrWeb => isMobile || isWeb;
}
