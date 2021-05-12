---
title: Pass arguments to a named route
description: How to pass arguments to a named route.
prev:
  title: Navigate with named routes
  path: /docs/cookbook/navigation/named-routes
next:
  title: Return data from a screen
  path: /docs/cookbook/navigation/returning-data
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/navigation/navigate_with_arguments"?>

The [`Navigator`][] provides the ability to navigate
to a named route from any part of an app using
a common identifier.
In some cases, you might also need to pass arguments to a
named route. For example, you might wish to navigate to the `/user` route and
pass information about the user to that route.

You can accomplish this task using the `arguments` parameter of the
[`Navigator.pushNamed()`][] method. Extract the arguments using the
[`ModalRoute.of()`][] method or inside an [`onGenerateRoute()`][]
function provided to the [`MaterialApp`][] or [`CupertinoApp`][]
constructor.

This recipe demonstrates how to pass arguments to a named
route and read the arguments using `ModalRoute.of()`
and `onGenerateRoute()` using the following steps:

  1. Define the arguments you need to pass.
  2. Create a widget that extracts the arguments.
  3. Register the widget in the `routes` table.
  4. Navigate to the widget.

## 1. Define the arguments you need to pass

First, define the arguments you need to pass to the new route.
In this example, pass two pieces of data:
The `title` of the screen and a `message`.

To pass both pieces of data, create a class that stores this information.

<?code-excerpt "lib/main.dart (ScreenArguments)"?>
```dart
// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
```

## 2. Create a widget that extracts the arguments

Next, create a widget that extracts and displays the
`title` and `message` from the `ScreenArguments`.
To access the `ScreenArguments`,
use the [`ModalRoute.of()`][] method.
This method returns the current route with the arguments.

<?code-excerpt "lib/main.dart (ExtractArgumentsScreen)"?>
```dart
// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}
```

## 3. Register the widget in the `routes` table

Next, add an entry to the `routes` provided to the `MaterialApp` widget. The
`routes` define which widget should be created based on the name of the route.

{% comment %}
RegEx removes the return statement and adds the closing parenthesis at the end
{% endcomment %}
<?code-excerpt "lib/main.dart (Routes)" replace="/return //g;/$/\n)/g"?>
```dart
MaterialApp(
  routes: {
    ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
  },
)
```


## 4. Navigate to the widget

Finally, navigate to the `ExtractArgumentsScreen`
when a user taps a button using [`Navigator.pushNamed()`][].
Provide the arguments to the route via the `arguments` property. The
`ExtractArgumentsScreen` extracts the `title` and `message` from these
arguments.

<?code-excerpt "lib/main.dart (PushNamed)"?>
```dart
// A button that navigates to a named route.
// The named route extracts the arguments
// by itself.
ElevatedButton(
  onPressed: () {
    // When the user taps the button,
    // navigate to a named route and
    // provide the arguments as an optional
    // parameter.
    Navigator.pushNamed(
      context,
      ExtractArgumentsScreen.routeName,
      arguments: ScreenArguments(
        'Extract Arguments Screen',
        'This message is extracted in the build method.',
      ),
    );
  },
  child: Text('Navigate to screen that extracts arguments'),
),
```

## Alternatively, extract the arguments using `onGenerateRoute`

Instead of extracting the arguments directly inside the widget, you can also
extract the arguments inside an [`onGenerateRoute()`][]
function and pass them to a widget.

The `onGenerateRoute()` function creates the correct route based on the given
[`RouteSettings`][].

{% comment %}
RegEx removes the return statement, removed "routes" property and adds the closing parenthesis at the end
{% endcomment %}
<?code-excerpt "lib/main.dart (OnGenerateRoute)" replace="/^return //g;/  routes:((.)*\n){3}//g;/$/\n)/g"?>
```dart
MaterialApp(
  // Provide a function to handle named routes.
  // Use this function to identify the named
  // route being pushed, and create the correct
  // Screen.
  onGenerateRoute: (settings) {
    // If you push the PassArguments route
    if (settings.name == PassArgumentsScreen.routeName) {
      // Cast the arguments to the correct
      // type: ScreenArguments.
      final args = settings.arguments as ScreenArguments;

      // Then, extract the required data from
      // the arguments and pass the data to the
      // correct screen.
      return MaterialPageRoute(
        builder: (context) {
          return PassArgumentsScreen(
            title: args.title,
            message: args.message,
          );
        },
      );
    }
    // The code only supports
    // PassArgumentsScreen.routeName right now.
    // Other values need to be implemented if we
    // add them. The assertion here will help remind
    // us of that higher up in the call stack, since
    // this assertion would otherwise fire somewhere
    // in the framework.
    assert(false, 'Need to implement ${settings.name}');
    return null;
  },
)
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },
      // Provide a function to handle named routes.
      // Use this function to identify the named
      // route being pushed, and create the correct
      // Screen.
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as ScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      title: 'Navigation with Arguments',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // A button that navigates to a named route.
            // The named route extracts the arguments
            // by itself.
            ElevatedButton(
              onPressed: () {
                // When the user taps the button,
                // navigate to a named route and
                // provide the arguments as an optional
                // parameter.
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Extract Arguments Screen',
                    'This message is extracted in the build method.',
                  ),
                );
              },
              child: Text('Navigate to screen that extracts arguments'),
            ),
            // A button that navigates to a named route.
            // For this route, extract the arguments in
            // the onGenerateRoute function and pass them
            // to the screen.
            ElevatedButton(
              onPressed: () {
                // When the user taps the button, navigate
                // to a named route and provide the arguments
                // as an optional parameter.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute function.',
                  ),
                );
              },
              child: Text('Navigate to a named that accepts arguments'),
            ),
          ],
        ),
      ),
    );
  }
}

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

// A Widget that accepts the necessary arguments via the
// constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor
  // parameters. It does not extract the arguments from
  // the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute
  // function provided to the MaterialApp widget.
  const PassArgumentsScreen({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
```

<noscript>
  <img src="/images/cookbook/navigate-with-arguments.gif" alt="Demonstrates navigating to different routes with arguments" class="site-mobile-screenshot" />
</noscript>


[`CupertinoApp`]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[`ModalRoute.of()`]: {{site.api}}/flutter/widgets/ModalRoute/of.html
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Navigator.pushNamed()`]: {{site.api}}/flutter/widgets/Navigator/pushNamed.html
[`onGenerateRoute()`]: {{site.api}}/flutter/widgets/WidgetsApp/onGenerateRoute.html
[`RouteSettings`]: {{site.api}}/flutter/widgets/RouteSettings-class.html
