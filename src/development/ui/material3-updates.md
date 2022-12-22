---
title: Material 3 updates
description: Learn about Material 3 for Flutter.
---
Material 3, also known as Material You, is the next generation of Material 
Design. 
With new features and widget updates, UI design is more uniform 
across platforms. So your app will look similar whether running 
on mobile or on a desktop.
This guide gives a high-level overview of Material 3, highlights key updates, 
and shows you how to enable Material 3 for your Flutter application.

## What is Material 3? 
Material 3 is the latest version of Material Design, 
a UI/UX design system created by Google. 
Material design enables developers and designers to build optimal user 
experiences on Flutter and other platforms. 
Material 3 provides updated features like dynamic color, elevation, 
and typography.

## Key updates
Material 3 introduced several major changes from Material 2. 
The Flutter team continues migrating Flutter's UI components to the Material 3 
specifications, and most (but not all) will be implemented 
by the next stable release. You can demo the Material 3 features 
with the [Material 3 Flutter][] showcase.

The following sections cover some of the new updates available in the next
stable release.     

### New widgets

* [`ElevatedButton`][]: Provides button choice based on the 
  importance of the action. 
* [`NavigationBar`][]: Enables switching between primary routes 
in your app. This widget replaces `BottomNavigationBar`.
* [`NavigationDrawer`][]: Provides another way to switch between primary
routes in your app. 
* [`SegmentedButton`][]: Provides multiple selection options and 
views for buttons.

#### Styled buttons 
* [`FilledButton`][]: Emphasizes important buttons that complete a workflow, 
such as FINISH, DONE, or SUBMIT. 
* [`FilledButton.tonal`][]: Provides a more emphatic version of an 
outlined button.

### Updated widgets
The following list outlines some key widgets that are updated to support 
Material 3. 
* [`FloatingActionButton` (FAB)][] 
* [`OutlinedButton`][] 

Some of these widgets have more features.

* [`AppBar`][]: Introduces new colors, elevation, and layout. 
* [`Card`][]: Introduces new types of cards: elevated, filled, and outlined. 
* [`ColorScheme`][]: Introduces dynamic color, design tokens, and color 
  contrast accessibility standards. 
* [`IconButton`][]: Introduces two new types of IconButton: 
  standard and contained.  

You can follow the migration of Flutter to Material 3 in the 
[Bring Material 3 to Flutter][] GitHub issue.

## How to use Material 3 in your Flutter app

By default, all Material widgets use Material 2.
To enable Material 3, define a theme of [`ThemeData`][] 
in your [`MaterialApp`][] class, and set its [`useMaterial3`][] 
property to `true`.
In using this property, you opt-in to use Material 3. 

```dart
void main() {
  runApp(
    MaterialApp(
      title: 'Material 3 property',
      theme: ThemeData(
        useMaterial3: true
      ),
    ),
  );
}
```

{{site.alert.note}}
  The migration to Material 3 is ongoing, 
  opting in might produce an inconsistent look.
{{site.alert.end}}

## Learn more

To learn more about Material 3 updates and the migration of Flutter to Material 3, 
check out:    

* [Bring Material 3 to Flutter][] GitHub issue 
* [Material 3 - Flutter][] page 
* [Material 3 Flutter][] showcase
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
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[Material 3 - Flutter]: https://m3.material.io/develop/flutter
[Material 3 Flutter]: https://flutter.github.io/samples/web/material_3_demo
[Migrating a Flutter app to Material 3]: https://blog.codemagic.io/migrating-a-flutter-app-to-material-3/
[Migrating to Material Design 3]: https://material.io/blog/blog/blog/migrating-material-3
[`NavigationBar`]: {{site.api}}/flutter/material/NavigationBar-class.html
[`NavigationDrawer`]: https://m3.material.io/components/navigation-drawer/overview 
[`OutlinedButton`]:  {{site.api}}/flutter/material/OutlinedButton-class.html
[`SegmentedButton`]: https://m3.material.io/components/segmented-buttons/overview
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html