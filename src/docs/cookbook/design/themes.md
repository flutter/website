---
title: Using Themes to share colors and font styles
short-title: Themes
description: How to share colors and font styles throughout an app using Themes.
---

In order to share colors and font styles throughout our app, we can take
advantage of themes. There are two ways to define themes: App-wide or using
`Theme` Widgets that define the colors and font styles for a particular part of
our application. In fact, app-wide themes are just `Theme` Widgets created at
the root of our apps by the `MaterialApp`!

After we define a Theme, we can use it within our own Widgets. In addition, the
Material Widgets provided by Flutter will use our Theme to set the background
colors and font styles for AppBars, Buttons, Checkboxes, and more.

## Creating an app theme

In order to share a Theme containing colors and font styles across our entire
app, we can provide
[`ThemeData`](https://docs.flutter.io/flutter/material/ThemeData-class.html)
to the `MaterialApp` constructor.

If no `theme` is provided, Flutter creates a fallback theme under the hood.

<!-- skip -->
```dart
MaterialApp(
  title: title,
  theme: ThemeData(
    // Define the default Brightness and Colors
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.cyan[600],
    
    // Define the default Font Family
    fontFamily: 'Montserrat',
    
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  )
);
```

Please see the [ThemeData](https://docs.flutter.io/flutter/material/ThemeData-class.html)
documentation to see all of the colors and fonts you can define.

## Themes for part of an application

If we want to override the app-wide theme in part of our application, we can
wrap a section of our app in a `Theme` Widget.

There are two ways to approach this: creating unique `ThemeData`, or
extending the parent theme.

### Creating unique `ThemeData`

If we don't want to inherit any application colors or font styles, we can create
a `ThemeData()` instance and pass that to the `Theme` Widget.

<!-- skip -->
```dart
Theme(
  // Create a unique theme with "ThemeData"
  data: ThemeData(
    accentColor: Colors.yellow,
  ),
  child: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
);
```

### Extending the parent theme

Rather than overriding everything, it often makes sense to extend the parent
theme. We can achieve this by using the
[`copyWith`](https://docs.flutter.io/flutter/material/ThemeData/copyWith.html)
method.

<!-- skip -->
```dart
Theme(
  // Find and Extend the parent theme using "copyWith". Please see the next
  // section for more info on `Theme.of`.
  data: Theme.of(context).copyWith(accentColor: Colors.yellow),
  child: FloatingActionButton(
    onPressed: null,
    child: Icon(Icons.add),
  ),
);
```

## Using a Theme

Now that we've defined a theme, we can use it within our Widget `build` methods
by using the `Theme.of(context)` function!

`Theme.of(context)` looks up the Widget tree and return the nearest `Theme`
in the tree. If we have a stand-alone `Theme` defined above our Widget, it
returns that. If not, it returns the App theme.

In fact, the `FloatingActionButton` uses this exact technique to find the
`accentColor`!

<!-- skip -->
```dart
Container(
  color: Theme.of(context).accentColor,
  child: Text(
    'Text with a background color',
    style: Theme.of(context).textTheme.title,
  ),
);
```

## Complete example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'Custom Themes';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default Font Family
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Text(
            'Text with a background color',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.yellow),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

![Themes Demo](/images/cookbook/themes.png){:.site-mobile-screenshot}
