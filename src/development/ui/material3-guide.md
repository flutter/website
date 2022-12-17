---
title: Material 3 development guide
description: Learn about Material 3 for Flutter.
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

# Material 3 development guide
Material 3, also known as Material You, is the next phase of Material Design. 
With new features and widget updates, cross-platform design is more uniform. 
This document gives a high-level overview of Material 3, highlights key updates, 
and shows you how to enable Material 3 for your Flutter application.

## What is Material 3? 
Material 3 is the latest version of Material Design. 
Material Design is a UI/UX design system, including guidelines, 
components, and tools created by Google. 
It enables developers and designers to build optimal user experiences 
on Flutter and other platforms. 
Material 3 provides updated features like dynamic color, elevation, 
and typography.

## Key updates
Though the migration to Material 3 is still in progress, 
there are several major changes from older Material versions. 
You can demo the Material 3 features with the Material 3 Flutter Showcase.

### New widgets

* `NavigationBar` 
  * Enables switching between primary destinations in your app. 
* `NavigationDrawer` 
  * Provides intuitive access to targets in your app. 
* `SegmentedButton` 
  * Provides multiple selection options and views for buttons.

#### Styled buttons 
* `FilledButton` 
  * Indicates important button actions. 
*`FilledButton.tonal` 
  * Combines outlined and filled buttons.

### Updated widgets
The following list of widgets supports Material 3 design in Flutter. 
Some of these widgets have more feature additions. 
The migration of Material 3 to Flutter is ongoing and tracked in the 
Bring Material 3 to Flutter GitHub issue.

* `AppBar` 
  * Introduces new colors, elevation, and layout. 
  * Supports Material 3.
*`Card`  
  * Introduces new types of cards; elevated, filled, and outlined. 
  * Supports Material 3. 
* `ColorScheme` 
  * Introduces dynamic color, design tokens, and color contrast accessibility standards. 
  * Supports Material 3.
* `ElevatedButton`
  * Supports Material 3. 
* `FloatingActionButton` (FAB) 
  * Supports Material 3. 
* `IconButton`  
  * Introduces two new types of IconButton, standard and contained. 
  * Supports Material 3
* `OutlinedButton` 
  * Updated to support Material 3. 

## How to use Material 3 in your Flutter app

Material 3 is available by opting in with the `useMaterial3` property. 
Setting this property to `true` will enable all the new Material 3 features. 

<?code-excerpt "lib/main_tutorial.dart"?>
```run-dartpad:theme-light:mode-flutter:run-false:width-100%:height-600px:split-60:ga_id-starting_code
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Tutorial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      home: const Material3Example(),
    ),
  );
}

class Material3Example extends StatelessWidget {
  const Material3Example({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Material 3'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),

      body: const Center(
        child: Text('This app uses Material 3'),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

Note: Since the migration to Material 3 is still in progress, opting in may produce an inconsistent look. 
Resources
For more information on Material 3 and updates on the migration of Material 3 to Flutter, checkout:
[Bring Material 3 to Flutter][] GitHub issue 
[M3 Flutter][] 
[Migrating a Flutter app to Material 3][] by Taha Tesser
[Migrating to Material Design 3][] by James Williams