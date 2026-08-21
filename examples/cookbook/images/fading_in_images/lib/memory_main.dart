// #docregion TransparentImage
import 'dart:convert';
import 'dart:typed_data';
// #enddocregion TransparentImage

import 'package:flutter/material.dart';

// #docregion TransparentImage
final Uint8List transparentImage = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4'
  'nGMAAQAABQABDQottAAAAABJRU5ErkJggg==',
);
// #enddocregion TransparentImage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            Center(
              // #docregion MemoryNetwork
              child: FadeInImage.memoryNetwork(
                placeholder: transparentImage,
                image: 'https://picsum.photos/250?image=9',
              ),
              // #enddocregion MemoryNetwork
            ),
          ],
        ),
      ),
    );
  }
}
