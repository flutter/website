// ignore_for_file: unused_local_variable

// #enddocregion Import
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// #docregion Import
import 'package:flutter/widgets.dart';

class IOSCompositionWidget extends StatelessWidget {
  const IOSCompositionWidget({super.key});

  @override
  // #docregion iOSCompositionWidget
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
  // #enddocregion iOSCompositionWidget
}

class TogetherWidget extends StatelessWidget {
  const TogetherWidget({super.key});

  @override
  // #docregion TogetherWidget
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
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
  // #enddocregion TogetherWidget
}
