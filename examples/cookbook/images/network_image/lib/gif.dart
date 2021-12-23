import 'package:flutter/material.dart';

class MyGif extends StatelessWidget {
  const MyGif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // #docregion Gif
    return Image.network(
        'https://github.com/flutter/plugins/raw/master/packages/video_player/video_player/doc/demo_ipod.gif?raw=true');
    // #enddocregion Gif
  }
}
