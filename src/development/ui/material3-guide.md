---
title: Material 3 development guide
description: Learn about Material 3 for Flutter.
---
Material 3, also known as Material You, is the next version of Material Design. 
With new features and widget updates, cross-platform design is more uniform. 
This guide gives a high-level overview of Material 3, highlights key updates, 
and shows you how to enable Material 3 for your Flutter application.

## What is Material 3? 
The latest version of Material Design. 
The Google UI/UX design system, including guidelines, 
components, and tools. 
It enables developers and designers to build optimal user experiences 
on Flutter and other platforms. 
Material 3 provides updated features like dynamic color, elevation, 
and typography.

## Key updates
Though the migration to Material 3 continues, 
it introduces several major changes from older Material versions. 
You can demo the Material 3 features with the Material 3 Flutter Showcase.

### New widgets

* [`NavigationBar`][]: Enables switching between primary destinations 
in your app.
* [`NavigationDrawer`][]: Provides intuitive access to targets in your app. 
* [`SegmentedButton`][]: Provides multiple selection options and 
views for buttons.

#### Styled buttons 
* [`FilledButton`][]: Indicates important button actions. 
* [`FilledButton.tonal`][]: Combines outlined and filled buttons.

### Updated widgets
The following list outlines some key widgets that support 
Material 3 design in Flutter. 
* [`ElevatedButton`][]
* [`FloatingActionButton` (FAB)][] 
* [`OutlinedButton`][] 

Some of these widgets have more features.

* [`AppBar`][]: Introduces new colors, elevation, and layout. 
* [`Card`][]: Introduces new types of cards; elevated, filled, and outlined. 
* [`ColorScheme`][]: Introduces dynamic color, design tokens, and color 
contrast accessibility standards. 
* [`IconButton`][]: Introduces two new types of IconButton, 
standard and contained.  

The community tracks the migration of Material 3 to Flutter in the 
[Bring Material 3 to Flutter][] GitHub issue.

## How to use Material 3 in your Flutter app

By default, all Material widgets use Material 2.
To enable Material 3, construct [`ThemeData()`][] with the 
[`useMaterial3` property][] set to `true`.
In using this property, you choose, or opt-in to use Material 3. 

```dart
void main() {
  runApp(
    MaterialApp(
      title: 'Material 3 Property',
      theme: ThemeData(),
        useMaterial3: true,
      ),
    ),
  );
}
```

{{site.alert.note}}
  The migration to Material 3 is ongoing, 
  opting in may produce an inconsistent look.
{{site.alert.end}}

## Learn more

To learn more about Material 3 updates and the migration of Material 3 to Flutter, 
check out:    

* [Bring Material 3 to Flutter][] GitHub issue 
* [Material 3 - Flutter][] page 
* [Migrating a Flutter app to Material 3][] blog post by Taha Tesser
* [Migrating to Material Design 3][] blog post by James Williams

[`AppBar`]: {{site.api}}/flutter/material/AppBar-class.html
[Bring Material 3 to Flutter]: {{site.github}}//flutter/flutter/issues/91605
[`Card`]: {{site.api}}/flutter/material/Card-class.html
[`ColorScheme`]: {{site.api}}/flutter/material/ColorScheme-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`FilledButton`]: https://m3.material.io/components/buttons/guidelines#9ecffdb3-ef29-47e7-8d5d-f78b404fcafe
[`FilledButton.tonal`]: https://m3.material.io/components/buttons/guidelines#07a1577b-aaf5-4824-a698-03526421058b
[`FloatingActionButton` (FAB)]: https://m3.material.io/components/floating-action-button/overview
[`IconButton`]: {{site.api}}/flutter/material/IconButton-class.html
[`MaterialApp()`]: {{site.api}}/flutter/material/MaterialApp-class.html
[Material 3 - Flutter]: https://m3.material.io/develop/flutter
[Migrating a Flutter app to Material 3]: https://blog.codemagic.io/migrating-a-flutter-app-to-material-3/
[Migrating to Material Design 3]: https://material.io/blog/blog/blog/migrating-material-3
[`NavigationBar`]: {{site.api}}/flutter/material/NavigationBar-class.html
[`NavigationDrawer`]: https://m3.material.io/components/navigation-drawer/overview 
[`OutlinedButton`]:  {{site.api}}/flutter/material/OutlinedButton-class.html
[`SegmentedButton`]: https://m3.material.io/components/segmented-buttons/overview
[`ThemeData()`]: {{site.api}}/flutter/material/ThemeData-class.html
[`useMaterial3` property]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html