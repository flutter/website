import 'package:flutter/material.dart';

class MyGif extends StatelessWidget {
  const MyGif({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion Gif
    return Image.network(
        'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif');
    // #enddocregion Gif
  }
}
