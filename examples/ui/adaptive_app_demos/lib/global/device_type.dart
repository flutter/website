import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  // #docregion platforms
  bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);
  bool get isDesktopDevice =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
  bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;
  bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;
  // #enddocregion platforms
}

// #docregion styling
class Insets {
  static const double xsmall = 3;
  static const double small = 4;
  static const double medium = 5;
  static const double large = 10;
  static const double extraLarge = 20;
  // etc
}

class Fonts {
  static const String raleway = 'Raleway';
  // etc
}

class TextStyles {
  static const TextStyle raleway = TextStyle(fontFamily: Fonts.raleway);
  static TextStyle buttonText1 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  static TextStyle buttonText2 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 11,
  );
  static TextStyle h1 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );
  static TextStyle h2 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static TextStyle body1 = raleway.copyWith(color: const Color(0xFF42A5F5));
  // etc
}
// #enddocregion styling

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion use-constants
    return Padding(
      padding: const EdgeInsets.all(Insets.small),
      child: Text('Hello!', style: TextStyles.body1),
    );
    // #enddocregion use-constants
  }
}
