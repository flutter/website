---
title: Pass arguments to a named route
prev:
  title: Navigate with named routes
  path: /docs/cookbook/navigation/named-routes
next:
  title: Return data from a screen
  path: /docs/cookbook/navigation/returning-data
---
 
The [`Navigator`](https://docs.flutter.io/flutter/widgets/Navigator-class.html)
provides the ability to navigate to a named route from any part of an app using
a common identifier. In some cases, you may also need to pass arguments to a
named route. For example, you may wish to navigate to the `/user` route and
pass information about the user to that route.

In Flutter, you can accomplish this task by providing additional `arguments` to
the
[`Navigator.pushNamed`](https://docs.flutter.io/flutter/widgets/Navigator/pushNamed.html)
method. You can extract the arguments using the
[`ModalRoute.of`](https://docs.flutter.io/flutter/widgets/ModalRoute/of.html)
method or inside an
[`onGenerateRoute`](https://docs.flutter.io/flutter/widgets/WidgetsApp/onGenerateRoute.html)
function provided to the
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
or
[`CupertinoApp`](https://docs.flutter.io/flutter/cupertino/CupertinoApp-class.html)
constructor.

This recipe demonstrates how to pass arguments to a named route and read the
arguments using `ModelRoute.of` and `onGenerateRoute`.

## Directions

  1. Define the arguments you need to pass
  2. Create a widget that extracts the arguments
  3. Register the widget in the `routes` table 
  4. Navigate to the widget

## 1. Define the arguments you need to pass

First, define the arguments you need to pass to the new route. In this example,
pass two pieces of data: The `title` of the screen and a `message`.

To pass both pieces of data, create a class that stores this information.

<!-- skip -->
```dart
// You can pass any object to the arguments parameter. In this example, create a
// class that contains both a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
```

## 2. Create a widget that extracts the arguments

Next, create a widget that extracts and displays the `title` and `message` from
the `ScreenArguments`. To access the `ScreenArguments`, use the
[`ModalRoute.of`](https://docs.flutter.io/flutter/widgets/ModalRoute/of.html)
method. This method returns the current route with the arguments.

<!-- skip -->
```dart
// A Widget that extracts the necessary arguments from the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

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

Next, add an entry to the `routes` provided to the `MaterialApp` Widget. The
`routes` define which widget should be created based on the name of the route.  

<!-- skip -->
```dart
MaterialApp(
  routes: {
    ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
  },     
);
```


## 4. Navigate to the widget

Finally, navigate to the `ExtractArgumentsScreen` when a user taps a button
using
[`Navigator.pushNamed`](https://docs.flutter.io/flutter/widgets/Navigator/pushNamed.html).
Provide the arguments to the route via the `arguments` property. The
`ExtractArgumentsScreen` extracts the `title` and `message` from these
arguments.

<!-- skip -->
```dart
// A button that navigates to a named route that. The named route
// extracts the arguments by itself.
RaisedButton(
  child: Text("Navigate to screen that extracts arguments"),
  onPressed: () {
    // When the user taps the button, navigate to the specific rout
    // and provide the arguments as part of the RouteSettings.
    Navigator.pushNamed(
      context,
      ExtractArgumentsScreen.routeName,
      arguments: ScreenArguments(
        'Extract Arguments Screen',
        'This message is extracted in the build method.',
      ),
    );
  },
);
```  

## Alternatively, extract the arguments using `onGenerateRoute`

Instead of extracting the arguments directly inside the widget, you can also
extract the arguments inside an
[`onGenerateRoute`](https://docs.flutter.io/flutter/widgets/WidgetsApp/onGenerateRoute.html)
function and pass them to a widget.

The `onGenerateRoute` function creates the correct route based on the given
`RouteSettings`.

<!-- skip -->
```dart
MaterialApp(
  // Provide a function to handle named routes. Use this function to
  // identify the named route being pushed and create the correct
  // Screen.
  onGenerateRoute: (settings) {
    // If you push the PassArguments route
    if (settings.name == PassArgumentsScreen.routeName) {
      // Cast the arguments to the correct type: ScreenArguments.
      final ScreenArguments args = settings.arguments;

      // Then, extract the required data from the arguments and
      // pass the data to the correct screen.
      return MaterialPageRoute(
        builder: (context) {
          return PassArgumentsScreen(
            title: args.title,
            message: args.message,
          );
        },
      );
    }
  },
);
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Provide a function to handle named routes. Use this function to
      // identify the named route being pushed and create the correct
      // Screen.
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          // Cast the arguments to the correct type: ScreenArguments.
          final ScreenArguments args = settings.arguments;

          // Then, extract the required data from the arguments and
          // pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
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
            // A button that navigates to a named route that. The named route
            // extracts the arguments by itself.
            RaisedButton(
              child: Text("Navigate to screen that extracts arguments"),
              onPressed: () {
                // When the user taps the button, navigate to the specific route
                // and provide the arguments as part of the RouteSettings.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExtractArgumentsScreen(),
                    // Pass the arguments as part of the RouteSettings. The
                    // ExtractArgumentScreen reads the arguments from these
                    // settings.
                    settings: RouteSettings(
                      arguments: ScreenArguments(
                        'Extract Arguments Screen',
                        'This message is extracted in the build method.',
                      ),
                    ),
                  ),
                );
              },
            ),
            // A button that navigates to a named route. For this route, extract
            // the arguments in the onGenerateRoute function and pass them
            // to the screen.
            RaisedButton(
              child: Text("Navigate to a named that accepts arguments"),
              onPressed: () {
                // When the user taps the button, navigate to a named route
                // and provide the arguments as an optional parameter.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute function.',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// A Widget that extracts the necessary arguments from the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

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

// A Widget that accepts the necessary arguments via the constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor parameters. It does not
  // extract the arguments from the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute function provided to the
  // MaterialApp widget.
  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
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

// You can pass any object to the arguments parameter. In this example, create a
// class that contains both a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
```

![Demonstrates navigating to different routes with arguments](/images/cookbook/navigate-with-arguments.gif){:.site-mobile-screenshot}
