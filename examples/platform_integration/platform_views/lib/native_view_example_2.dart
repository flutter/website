// #docregion import
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

// #enddocregion import

class VirtualDisplayWidget extends StatelessWidget {
  const VirtualDisplayWidget({super.key});

  @override
  // #docregion virtual-display
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  // #enddocregion virtual-display
}
