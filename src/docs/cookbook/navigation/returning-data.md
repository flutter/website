---
title: Return data from a screen
---

In some cases, we might want to return data from a new screen. For example, say
we push a new screen that presents two options to a user. When the user taps on
an option, we'll want to inform our first screen of the user's selection so it
can act on that information!

How can we achieve this? Using [`Navigator.pop`](https://docs.flutter.io/flutter/widgets/Navigator/pop.html)!

## Directions

  1. Define the home screen
  2. Add a button that launches the selection screen
  3. Show the selection screen with two buttons
  4. When a button is tapped, close the selection screen
  5. Show a snackbar on the home screen with the selection

## 1. Define the home screen

The home screen will display a button. When tapped, it will launch the selection
screen!

<!-- skip -->
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Returning Data Demo'),
      ),
      // We'll create the SelectionButton Widget in the next step
      body: Center(child: SelectionButton()),
    );
  }
}
```

## 2. Add a button that launches the selection screen

Now, we'll create our SelectionButton. Our selection button will:

  1. Launch the SelectionScreen when it's tapped
  2. Wait for the SelectionScreen to return a result

<!-- skip -->
```dart
class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Text('Pick an option, any option!'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      // We'll create the SelectionScreen in the next step!
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );
  }
}
```

## 3. Show the selection screen with two buttons

Now, we'll need to build a selection screen! It will contain two buttons. When
a user taps on a button, it should close the selection screen and let the home
screen know which button was tapped!

For now, we'll define the UI, and figure out how to return data in the next
step.

```dart
class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Pop here with "Yep"...
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Pop here with "Nope"
                },
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

## 4. When a button is tapped, close the selection screen

Now, we'll want to update the `onPressed` callback for both of our buttons! In
order to return data to the first screen, we'll need to use the
[`Navigator.pop`](https://docs.flutter.io/flutter/widgets/Navigator/pop.html)
method.

`Navigator.pop` accepts an optional second argument called `result`. If we
provide a result, it will be returned to the `Future` in our SelectionButton!

### Yep button

<!-- skip -->
```dart
RaisedButton(
  onPressed: () {
    // Our Yep button will return "Yep!" as the result
    Navigator.pop(context, 'Yep!');
  },
  child: Text('Yep!'),
);
```

### Nope button

<!-- skip -->
```dart
RaisedButton(
  onPressed: () {
    // Our Nope button will return "Nope!" as the result
    Navigator.pop(context, 'Nope!');
  },
  child: Text('Nope!'),
);
```

## 5. Show a snackbar on the home screen with the selection

Now that we're launching a selection screen and awaiting the result, we'll want
to do something with the information that's returned!

In this case, we'll show a Snackbar displaying the result. To do so, we'll
update the `_navigateAndDisplaySelection` method in our `SelectionButton`.

<!-- skip -->
```dart
_navigateAndDisplaySelection(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SelectionScreen()),
  );

  // After the Selection Screen returns a result, hide any previous snackbars
  // and show the new result!
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text("$result")));
}
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Returning Data',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Returning Data Demo'),
      ),
      body: Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Text('Pick an option, any option!'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop!
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result
                  Navigator.pop(context, 'Yep!');
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Nope!" as the result
                  Navigator.pop(context, 'Nope.');
                },
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

![Returning Data Demo](/images/cookbook/returning-data.gif){:.site-mobile-screenshot}
