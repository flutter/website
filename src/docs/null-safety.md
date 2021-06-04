---
title: Null safety in Flutter
description: Find out how to use non-nullable types in your Flutter code.
---

Flutter 2 supports null safety.
You can migrate your Flutter packages to use non-nullable types like this:

<?code-excerpt "../null_safety_examples/basics/lib/main.dart (MyApp)"?>
```dart
class MyApp extends StatelessWidget {
  final int anInt = 3; // Cannot be null.
  final int? aNullableInt = null; // Can be null.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nullable Fields Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nullable Fields Demo'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('anInt is $anInt.'),
              Text('aNullableInt is $aNullableInt.'),
            ],
          ),
        ),
      ),
    );
  }
}
```

For an instructor-led, free video workshop, check out the
following:

<iframe width="560" height="315" src="https://www.youtube.com/embed/HdKwuHQvArY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Resources

To learn more about null safety,
read these pages:

* [Sound null safety][]:
  The null safety homepage.
  Has basic information, with links to everything else you might need.
* [Understanding null safety][]:
  A deep dive into null safety, written by Dart engineer Bob Nystrom.

When you're ready to start migrating your packages to null safety,
check out these pages:

* [Migrating to null safety][]:
  Instructions for converting your packages to null safety.
* [Unsound null safety][]:
  Conceptual and practical information about mixed-mode programs,
  in which only some libraries are null safe.
* [FAQ][]:
  Questions that have come up during migration to null safety.
  
## Known issues

Not all parts of the Flutter SDK support null safety yet,
as some parts still need additional work to
[migrate to null safety]({{site.dart-site}}/null-safety/migration-guide).

We're currently aware of the following issues:

  * Migration of the pub.dev packages owned by the Flutter team
    is in progress. See pub.dev for
    [the current list]({{site.pub}}/packages?q=publisher%3Aflutter.dev&null-safe=1).
    We expect the majority of packages to be migrated in the coming weeks;
    the only exceptions we expect are the legacy `integration_tests` package,
    which is deprecated in favor of the version in the Flutter SDK itself
    (though see below), and some of the packages in
    <https://github.com/flutter/packages/tree/master/packages>
    which might take longer to be migrated.

  * Integration testing with
    [`flutter_driver`](/docs/cookbook/testing/integration/introduction) and 
    the version of `integration_test` in the Flutter SDK.
    
      * Currently, these methods do not support null safety on the host
        side of the test. You can drive a null-safe application, but the test
        itself won't use null-safe Dart.
      * Depending on the `flutter_driver` and `integration_test` packages
        will limit your ability to pick up some already migrated dependencies
        such as `args`, `archive`, and `crypto`,
        since these packages themselves depend on the non-migrated versions.
        
    We expect to have this resolved in the first half of 2021.

If you are interested in seeing the latest updates before they
reach the beta and stable branches,
and are willing to live on the bleeding edge,
consider using dev builds (`flutter channel dev`).

[Migrating to null safety]: {{site.dart-site}}/null-safety/migration-guide
[FAQ]: {{site.dart-site}}/null-safety/faq
[Sound null safety]: {{site.dart-site}}/null-safety
[Understanding null safety]: {{site.dart-site}}/null-safety/understanding-null-safety
[Unsound null safety]: {{site.dart-site}}/null-safety/unsound-null-safety
