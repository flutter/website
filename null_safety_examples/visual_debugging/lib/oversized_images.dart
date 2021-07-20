import 'package:flutter/material.dart';

// #docregion Toggle
import 'package:flutter/painting.dart';

void showOversizedImages() {
  debugInvertOversizedImages = true;
}
// #enddocregion Toggle

// #docregion ResizedImage
class ResizedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'dash.png',
      cacheHeight: 213,
      cacheWidth: 392,
    );
  }
}
// #enddocregion ResizedImage