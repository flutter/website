import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      // #docregion asset-image
      image: AssetImage('images/a_dot_burr.jpeg'),
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
