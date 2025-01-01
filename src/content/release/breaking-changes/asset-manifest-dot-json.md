---
title: Removal of AssetManifest.json
description: >-
    Built Flutter apps will no longer include an AssetManifest.json asset file.
---

## Summary

Flutter apps included an asset file named `AssetManifest.json`.
This file effectively contains a list of assets.
Application code can read it using the [`AssetBundle`][] API to
determine what assets are available at runtime.

The `AssetManifest.json` file is an undocumented implementation detail.
It's no longer used by the framework, and it's planned to
no longer generate it in a future release of Flutter.
If your app's code needs to get a list of available assets,
use the [`AssetManifest`][] API instead.

## Migration guide

### Reading asset manifest from Flutter application code

Before:

```dart
import 'dart:convert';
import 'package:flutter/services.dart';

void readAssetList() async {
  final assetManifestContent = await rootBundle.loadString('AssetManifest.json');
  final decodedAssetManifest =
      json.decode(assetManifestContent) as Map<String, Object?>;
  final assets = decodedAssetManifest.keys.toList().cast<String>();
}
```

After:

```dart
import 'package:flutter/services.dart';

void readAssetList() async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final assets = assetManifest.listAssets();
}
```

### Reading asset manifest information from Dart code outside of a Flutter app

The `flutter` CLI tool generates a new file, `AssetManifest.bin`.
This replaces `AssetManifest.json`.
This file contains the same information as `AssetManifest.json`,
but in a different format.
If you need to read this file from code that isn't part of a Flutter app, and
therefore can't use the [`AssetManifest`][] API,
you can still parse the file yourself.

The [`standard_message_codec`][] package can be used to parse the contents.

```dart
import 'dart:io';
import 'dart:typed_data';

import 'package:standard_message_codec/standard_message_codec.dart';

void main() {
  // The path to AssetManifest.bin depends on the target platform.
  final pathToAssetManifest = './build/web/assets/AssetManifest.bin';
  final manifest = File(pathToAssetManifest).readAsBytesSync();
  final decoded = const StandardMessageCodec()
      .decodeMessage(ByteData.sublistView(manifest));
  final assets = decoded.keys.cast<String>().toList();
}
```

Keep in mind that `AssetManifest.bin` is an implementation detail of Flutter.
Reading this file isn't an officially supported workflow.
The contents or format of the file might change in
a future Flutter release without an announcement.

## Timeline

`AssetManifest.json` will no longer be generated starting with
the fourth stable release after 3.19 or one year after the release of 3.19,
whichever comes later.

## References

Relevant issues:

* When building a Flutter app, the flutter tool generates an
  `AssetManifest.json` file that's unused by the framework [(Issue #143577)][]

[`AssetBundle`]: {{site.api}}/flutter/services/AssetBundle-class.html
[`AssetManifest`]: {{site.api}}/flutter/services/AssetManifest-class.html
[(Issue #143577)]: {{site.repo.flutter}}/issues/143577
[`standard_message_codec`]: {{site.pub-pkg}}/standard_message_codec
