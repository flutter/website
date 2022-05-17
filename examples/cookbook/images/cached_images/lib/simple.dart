import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SimpleImage extends StatelessWidget {
  const SimpleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // #docregion SimpleCachedImage
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/250?image=9',
    );
    // #enddocregion SimpleCachedImage
  }
}
