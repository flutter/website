---
title: Removal of AssetManifest.json
description: >-
    Built Flutter apps will no longer include an AssetManifest.json asset file.
---

## Summary

Flutter apps currently include an asset file named AssetManifest.json. This file
effectively contains a list of assets. Application code can read it using the
[AssetBundle][] API to determine what assets are available at runtime.

The AssetManifest.json file is an undocumented implementation detail.
It's no longer used by the framework, so it will no longer be
generated in a future release.
If your application code needs to get a list of available assets, use
the [AssetManifest][] API instead.

## Migration guide

Before:

```dart
import 'dart:convert';
import 'package:flutter/services.dart';

final String assetManifestContent = await rootBundle.loadString('AssetManifest.json');
final Map<Object?, Object?> decodedAssetManifest = 
    json.decode(assetManifestContent) as Map<String, Object?>;
final List<String> assets = decodedAssetManifest.keys.toList().cast();
```

After:

```dart
import 'package:flutter/services.dart';

final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
final List<String> assets = assetManifest.listAssets();
```

## Timeline

AssetManifest.json will no longer be generated started with the third stable
release after 3.20.

Landed in version: Not yet

Landed in stable: Not yet

## References

Relevant issues:

* When building a Flutter app, the flutter tool generates an AssetManifest.json file that is unused by the framework [(Issue #143577)][]

[AssetBundle]: {{site.api}}/flutter/services/AssetBundle-class.html
[AssetManifest]: {{site.api}}/flutter/services/AssetManifest-class.html
[(Issue #143577)]: {{site.repo.flutter}}/issues/143577
