import 'package:flutter/material.dart';

// #docregion toggle
void showOversizedImages() {
  debugInvertOversizedImages = true;
}
// #enddocregion toggle

// #docregion resized-image
class ResizedImage extends StatelessWidget {
  const ResizedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('dash.png', cacheHeight: 213, cacheWidth: 392);
  }
}

// #enddocregion resized-image
