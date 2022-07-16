import 'package:flutter/material.dart';

class ImageAssetExample extends StatelessWidget {
  const ImageAssetExample({super.key});

  // #docregion ImageAsset
  @override
  Widget build(BuildContext context) {
    return Image.asset('images/my_icon.png');
  }
  // #enddocregion ImageAsset
}

class AssetImageExample extends StatelessWidget {
  const AssetImageExample({super.key});

  // #docregion AssetImage
  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('images/my_image.png'),
    );
  }
  // #enddocregion AssetImage
}
