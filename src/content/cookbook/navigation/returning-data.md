---
title: Return data from a screen
description: How to return data from a new screen.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---
```dart

<?code-excerpt path-base="cookbook/navigation/returning_data/"?>

In some cases, you might want to return data from a new screen.
For example, say you push a new screen that presents two options to a user.
When the user taps an option, you want to inform the first screen
of the user's selection so that it can act on that information.

You can do this with the [`Navigator.pop()`][]
method using the following steps:

  1. Define the home screen
  2. Add a button that launches the selection screen
  3. Show the selection screen with two buttons
  4. When a button is tapped, close the selection screen
  5. Show a snackbar on the home screen with the selection

```dart

## 1. Define the home screen

The home screen displays a button. When tapped,
it launches the selection screen.

<?code-excerpt "lib/main_step2.dart (HomeScreen)"?>
```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Returning Data Demo'), // Change this title as needed
      ),
      body: const Center(
        child: SelectionButton(),
      ),
    );
  }
}

```dart
2. Add a button that launches the selection screen
Now, create the SelectionButton, which does the following:

Launches the SelectionScreen when it's tapped.
Waits for the SelectionScreen to return a result.
<?code-excerpt "lib/main_step2.dart (SelectionButton)"?>
```dart

class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Pick an option, any option!'),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result'))); // Customize Snackbar message if needed
  }
}

```dart

3. Show the selection screen with two buttons
Now, build a selection screen that contains two buttons. When a user taps a button, that app closes the selection screen and lets the home screen know which button was tapped.

<?code-excerpt "lib/main_step2.dart (SelectionScreen)"?>
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Yep!'); // Modify return string if needed
                },
                child: const Text('Yep!'), // Change this button text if needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Nope.'); // Modify return string if needed
                },
                child: const Text('Nope.'), // Change this button text if needed
              ),
            )
          ],
        ),
      ),
    );
  }
}
```dart
4. When a button is tapped, close the selection screen
Update the onPressed() callback for both buttons to return the desired results.

Yep button
<?code-excerpt "lib/main.dart (Yep)" replace="/^child: //g;/^\),$/)/g"?>
ElevatedButton(
  onPressed: () {
    Navigator.pop(context, 'Yep!'); // Modify return string if needed
  },
  child: const Text('Yep!'), // Change button text if needed
)
Nope button
<?code-excerpt "lib/main.dart (Nope)" replace="/^child: //g;/^\),$/)/g"?>
ElevatedButton(
  onPressed: () {
    Navigator.pop(context, 'Nope.'); // Modify return string if needed
  },
  child: const Text('Nope.'), // Change button text if needed
)

5. Show a snackbar on the home screen with the selection
In this case, show a snackbar displaying the result by using the _navigateAndDisplaySelection() method in SelectionButton.

<?code-excerpt "lib/main.dart (navigateAndDisplay)"?>

Future<void> _navigateAndDisplaySelection(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SelectionScreen()),
  );

  if (!context.mounted) return;

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$result'))); // Customize Snackbar message if needed
}


Interactive example
<?code-excerpt "lib/main.dart"?>
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Returning Data', // Change title as needed
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Returning Data Demo'), // Change this title as needed
      ),
      body: const Center(
        child: SelectionButton(),
      ),
    );
  }
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Pick an option, any option!'),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result'))); // Customize Snackbar message if needed
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Yep!'); // Modify return string if needed
                },
                child: const Text('Yep!'), // Change button text if needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Nope.'); // Modify return string if needed
                },
                child: const Text('Nope.'), // Change button text if needed
              ),
            )
          ],
        ),
      ),
    );
  }
}
<noscript> <img src="/assets/images/docs/cookbook/returning-data.gif" alt="Returning data demo" class="site-mobile-screenshot" /> </noscript>
