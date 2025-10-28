---
title: Create a horizontal list
description: How to implement a horizontal list.
---

<?code-excerpt path-base="cookbook/lists/horizontal_list"?>

You might want to create a list that scrolls
horizontally rather than vertically.
The [`ListView`][] widget supports horizontal lists.

Use the standard `ListView` constructor, passing in a horizontal
`scrollDirection`, which overrides the default vertical direction.

<?code-excerpt "lib/main.dart (list-view)" replace="/^child\: //g"?>
```dart highlightLines=2
ListView(
  scrollDirection: Axis.horizontal,
  children: [
    for (final color in Colors.primaries)
      Container(width: 160, color: color),
  ],
),
```

[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter horizontal list hands-on example in DartPad" run="true"
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Horizontal list';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 200,
          child: ScrollConfiguration(
            // Add a custom scroll behavior that
            // allows all devices to drag the list.
            behavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {...PointerDeviceKind.values},
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final color in Colors.primaries)
                  Container(width: 160, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/horizontal-list.webp" alt="Horizontal List Demo" class="site-mobile-screenshot" />
</noscript>
