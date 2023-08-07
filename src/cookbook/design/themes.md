---
title: Use themes to share colors and font styles
short-title: Themes
description: How to share colors and font styles throughout an app using Themes.
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="cookbook/design/themes"?>

{{site.alert.note}}
  This recipe uses the [Material 3 design specification][] and the [google_fonts] package.
{{site.alert.end}}

[Material 3 design specification]: https://m3.material.io
[google_fonts]: {{site.pub-pkg}}/google_fonts

To share colors and font styles throughout an app, use themes.

You can define app-wide themes, add widget `Theme` widgets, or both.
Each theme defines the colors, type style, and other parameters applicable
for the type of Material component.

Many Material 3 widgets have their own `Theme` widget and related `ThemeData` data class.
The `Theme` widget itself applies to the whole `MaterialApp`.

For example: [`TextButton`][] can use both [`TextButtonTheme`][] to apply a theme
and [`TextButtonThemeData`][] to define the visual properties of that theme.
Unlike the general app theme, the `TextButtonThemeData` can include the button's
width, height, padding, and other positioning choices.

[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`TextButtonTheme`]: {{site.api}}/flutter/material/TextButtonTheme-class.html
[`TextButtonThemeData`]: {{site.api}}/flutter/material/TextButtonThemeData-class.html

If a widget doesn't use a specific theme, the visual properties fall back
to the main theme. Precedence in themes rank from the specific widget,
to the widget type theme, to the general theme.

After you define a `Theme`, use it within your own widgets.
Flutter's Material widgets use your theme to set the background
colors and font styles for app bars, buttons, checkboxes, and more.

## Create an app theme

To share a `Theme` across your entire app, add a `theme` property
to your `MaterialApp` constructor.
This property takes a takes a [`ThemeData`][] widget.

To enable Material 3, add the [`useMaterial3`][] property
to the `ThemeData` widget.

If you don't add a theme to the constructor,
Flutter creates a default theme for you.

[`useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html

<?code-excerpt "lib/theme.dart (MaterialApp)" replace="/return //g"?>
```dart
MaterialApp(
  title: appName,
  theme: ThemeData(
    useMaterial3: true,

    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.purple,
      brightness: Brightness.dark,
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      displayLarge:
          const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      titleLarge:
          GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
      bodyMedium: GoogleFonts.merriweather(),
      displaySmall: GoogleFonts.pacifico(),
    ),
  ),
  home: const MyHomePage(
    title: appName,
  ),
);
```

Most `ThemeData` objects include two properties.

1. [`colorScheme`][] defines colors.
1. [`textTheme`][] defines text styling.

[`colorScheme`]: {{site.api}}/flutter/material/ThemeData/colorScheme.html
[`textTheme`]: {{site.api}}/flutter/material/ThemeData/textTheme.html

To learn what colors and fonts you can define,
check out the [`ThemeData`][] documentation.

## Override a theme

To override the overall theme in part of an app,
wrap that section of the app in a `Theme` widget.

You can override a theme in two ways:

1. Create a unique `ThemeData` instance.
2. Extend the parent theme.

{{site.alert.note}}
  To learn more, watch this short Widget of the Week video on the Theme widget:

  <iframe class="full-width" src="{{site.youtube-site}}/embed/oTvQDJOBXmM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
{{site.alert.end}}

### Set a unique `ThemeData` instance

If you want a component of your app to ignore the overall theme,
create a `ThemeData()` instance.
Pass that instance to the `Theme` widget.

<?code-excerpt "lib/theme.dart (Theme)"?>
```dart
Theme(
  // Create a unique theme with `ThemeData`
  data: ThemeData(
    primarySwatch: Colors.pink,
  ),
  child: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
);
```

### Extend the parent theme

Instead of overriding everything, consider extending the parent theme.
To extend a theme, use the [`copyWith()`][] method.

<?code-excerpt "lib/theme.dart (ThemeCopyWith)"?>
```dart
Theme(
  // Find and extend the parent theme using `copyWith`.
  // To learn more, check out the next
  // section on `Theme.of`.
  data: Theme.of(context)
      .copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)
          // TRY THIS: Change the seedColor to "Colors.red" or
          //           "Colors.blue"
          ),
  child: const FloatingActionButton(
    onPressed: null,
    child: Icon(Icons.add),
  ),
);
```

## Apply a Theme

To apply your new theme, add the `Theme.of(context)` method within the
widgets' `build()` methods.

The `Theme.of(context)` method looks up the widget tree and applies
the nearest `Theme` in the tree. If you have a standalone
`Theme` as defined in the previous example, that's applied.
If not, Flutter applies the app's theme.

In fact, the `FloatingActionButton` uses this technique to find the
`accentColor`.

<?code-excerpt "lib/theme.dart (Container)" replace="/^child: //g"?>
```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  color: theme.colorScheme.primary,
  child: Text(
    'Text with a background color',
    style: theme.textTheme.bodyMedium,
    // TRY THIS: Change the Text value
    //           or change the theme.textTheme
    //           to "displayLarge" or "displaySmall"
  ),
),
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example
import 'package:flutter/material.dart';
//Import the font package
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Custom Themes';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          brightness: Brightness.dark,
          // TRY THIS: Change to "Brightness.light"
          //           and see that all colors change
          //           to better contrast a light background
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge:
              const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge:
              GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
          // TRY THIS: Change one of the GoogleFonts
          //           to "lato", "poppins", or "lora"
          //           The title uses "titleLarge"
          //           and the middle text uses "bodyMedium"
        ),
      ),
      home: const MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Simplifies later use of Theme context

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: theme.colorScheme.primary,
          child: Text(
            'Text with a background color',
            style: theme.textTheme.bodyMedium,
            // TRY THIS: Change the Text value
            //           or change the theme.textTheme
            //           to "displayLarge" or "displaySmall"
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: theme.copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)
            // TRY THIS: Change the seedColor to "Colors.red" or
            //           "Colors.blue"
            ),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/themes.png" alt="Themes Demo" class="site-mobile-screenshot" />
</noscript>


[`copyWith()`]: {{site.api}}/flutter/material/ThemeData/copyWith.html
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
