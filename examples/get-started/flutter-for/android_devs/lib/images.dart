import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image:
          // #docregion asset-image
          AssetImage('images/my_icon.png'),
      // #enddocregion asset-image
    );
  }
}

class ImageExample extends StatelessWidget {
  const ImageExample({super.key});

  // #docregion image-asset
  @override
  Widget build(BuildContext context) {
    return Image.asset('images/my_image.png');
  }

  // #enddocregion image-asset
}
