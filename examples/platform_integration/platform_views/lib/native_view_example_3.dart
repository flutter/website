// ignore_for_file: unused_local_variable

// #docregion import
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// #enddocregion import
import 'package:flutter/widgets.dart';

class IOSCompositionWidget extends StatelessWidget {
  const IOSCompositionWidget({super.key});

  @override
  // #docregion ios-composition
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  // #enddocregion ios-composition
}

class TogetherWidget extends StatelessWidget {
  const TogetherWidget({super.key});

  @override
  // #docregion together-widget
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      // return widget on Android.
      case TargetPlatform.iOS:
      // return widget on iOS.
      case TargetPlatform.macOS:
      // return widget on macOS.
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  // #enddocregion together-widget
}
