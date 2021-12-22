// #docregion Import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// #enddocregion Import

class VirtualDisplayWidget extends StatelessWidget {
  const VirtualDisplayWidget({Key? key}) : super(key: key);

  @override
  // #docregion VirtualDisplayWidget
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'hybrid-view-type';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  // #enddocregion VirtualDisplayWidget
}
