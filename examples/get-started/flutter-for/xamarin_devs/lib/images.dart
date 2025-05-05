import 'package:flutter/material.dart';

class ImageAssetExample extends StatelessWidget {
  const ImageAssetExample({super.key});

  // #docregion image-asset
  @override
  Widget build(BuildContext context) {
    return Image.asset('images/my_icon.png');
  }

  // #enddocregion image-asset
}

class AssetImageExample extends StatelessWidget {
  const AssetImageExample({super.key});

  // #docregion asset-image
  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage('images/my_image.png'));
  }

  // #enddocregion asset-image
}
