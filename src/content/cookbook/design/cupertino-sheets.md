---
title: Display a Cupertino sheet
description: >-
  How to implement a Cupertino sheet to display messages and content.
---

<?code-excerpt path-base="cookbook/design/cupertino_sheets/"?>

A Cupertino sheet is an iOS-style modal bottom sheet
used to present content or options.
It slides up from the bottom of the screen
and can be pulled down to dismiss.

In Flutter, this is the job of [`showCupertinoSheet`][].
This recipe implements a Cupertino sheet using the following steps:

  1. Create a `CupertinoApp` or `MaterialApp`.
  2. Display the sheet content.

## 1. Create a `CupertinoApp`

When creating apps that follow the iOS design guidelines,
you can use `CupertinoApp`.
The following example provides a button in the center of the screen
that triggers the modal.

<?code-excerpt "lib/main.dart (CupertinoSheetDemo)"?>
```dart
class CupertinoSheetDemo extends StatelessWidget {
  const CupertinoSheetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'CupertinoSheet Demo',
      home: CupertinoSheetPage(),
    );
  }
}
```

## 2. Display the sheet content

With the basic app structure in place, display the sheet.
To show it, call `showCupertinoSheet` and provide a `builder`
that returns the content for the sheet, such as a `SingleChildScrollView`.

<?code-excerpt "lib/main.dart (ShowCupertinoSheet)"?>
```dart
showCupertinoSheet(
  context: context,
  builder: (context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 100),
            const Text('This is a Cupertino sheet'),
            const SizedBox(height: 20),
            CupertinoButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  },
);
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter CupertinoSheet hands-on example in DartPad" run="true"
import 'package:flutter/cupertino.dart';

void main() => runApp(const CupertinoSheetDemo());

class CupertinoSheetDemo extends StatelessWidget {
  const CupertinoSheetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'CupertinoSheet Demo',
      home: CupertinoSheetPage(),
    );
  }
}

class CupertinoSheetPage extends StatelessWidget {
  const CupertinoSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoSheet Demo'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () {
            showCupertinoSheet(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 100),
                        const Text('This is a Cupertino sheet'),
                        const SizedBox(height: 20),
                        CupertinoButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Show Sheet'),
        ),
      ),
    );
  }
}
```

[`showCupertinoSheet`]: {{site.api}}/flutter/cupertino/showCupertinoSheet.html
