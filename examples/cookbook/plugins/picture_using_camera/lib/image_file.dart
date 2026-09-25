import 'dart:io';

import 'package:material_ui/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion ImageFile
    return Image.file(File('path/to/my/picture.png'));
    // #enddocregion ImageFile
  }
}
