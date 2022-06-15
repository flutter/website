import 'package:flutter/material.dart';

// #docregion Toggle
void showOversizedImages() {
  debugInvertOversizedImages = true;
}
// #enddocregion Toggle

// #docregion ResizedImage
class ResizedImage extends StatelessWidget {
  const ResizedImage({super.key});

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