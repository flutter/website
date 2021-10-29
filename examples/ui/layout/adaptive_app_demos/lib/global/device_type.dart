import 'package:flutter/widgets.dart';
import 'package:universal_platform/universal_platform.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

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

  // #docregion Platforms
  bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);
  bool get isDesktopDevice =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
  bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;
  bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;
  // #enddocregion Platforms
}

// #docregion Styling
class InsetValues {
  static const double xsmall = 4;
  static const double small = 8;
  // etc
}

class Fonts {
  static const String raleway = 'Raleway';
  // etc
}

class TextStylesValues {
  static const TextStyle raleway = const TextStyle(
    fontFamily: Fonts.raleway,
  );
  static late TextStyle body1 = raleway.copyWith(color: Color(0xFF42A5F5));
  // etc
}
// #enddocregion Styling

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // #docregion UseConstants
    return Padding(
      padding: EdgeInsets.all(InsetValues.small),
      child: Text('Hello!', style: TextStylesValues.body1),
    );
    // #enddocregion UseConstants
  }
}
