---
layout: page
title: "Focus on a Text Field"
permalink: /cookbook/forms/focus/
---

When a text field is selected and accepting input, it is said to have "focus." 
Generally, users can focus text fields by tapping on them, and developers 
can focus text fields using the tools described in this recipe. 

Managing focus is fundamental tool for creating forms with an intuitive 
flow. For example, say we have a search screen with a text field. When 
the user navigates to the search screen, we can focus the search term text field. 
This allows the user to start typing as soon as the screen 
is visible, without needing to manually tap on the text field!

In this recipe, we'll learn how to focus a text field as soon as it's visible
as well as how to focus a text field when a button is tapped.

## Focus a text field as soon as it's visible

In order to focus a text field as soon as it's visible, we can use the 
`autofocus` property.

<!-- skip -->
```dart
new TextField(
  autofocus: true,
);
```

For more information on handling input and creating text fields, please see the
[Forms section of the cookbook](/cookbook#forms).

## Focus a text field when a button is tapped

Rather than immediately focusing a specific text field, we might need to focus a 
text field at a later point in time. In this example, we'll see how to focus a 
text field after the user presses a button. In the real world, you may also need 
to focus a specific text field in response to an api call or a validation error.

### Directions

  1. Create a `FocusNode`
  2. Pass the `FocusNode` to a `TextField`
  3. Focus the `TextField` when a button is tapped

### 1. Create a `FocusNode`

First, we'll need to create a [`FocusNode`](https://docs.flutter.io/flutter/widgets/FocusNode-class.html).
We will use the `FocusNode` to identify a specific `TextField` in Flutter's 
"focus tree." This will allow us to focus the `TextField` in the next steps.

Since focus nodes are long-lived objects, we need to store them in a `State` 
class. In addition, we need to `dispose` of them when they're no longer needed! 

<!-- skip -->
```dart
// Define a Custom Form Widget
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => new _MyFormState();
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class _MyFormState extends State<MyForm> {
  // Create the focus node. We will pass it to the TextField below.
  final FocusNode myFocusNode = new FocusNode();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    myFocusNode.dispose();
        
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We will fill this out in the next step!
  }
}
```

### 2. Pass the `FocusNode` to a `TextField`

Now that we have our `FocusNode`, we can pass it to a specific `TextField` in 
the `build` method. 

<!-- skip -->
```dart
class _MyFormState extends State<MyForm> {
  // Code to create the Focus node...

  @override
  Widget build(BuildContext context) {
    return new TextField(
      focusNode: myFocusNode,
    );
  }
}
```

### 3. Focus the `TextField` when a button is tapped

Finally, we'll want to focus the text field when the user taps a floating 
action button! We'll use the [`requestFocus`](https://docs.flutter.io/flutter/widgets/FocusScopeNode/requestFocus.html) 
method to achieve this task.

<!-- skip -->
```dart
new FloatingActionButton(
  // When the button is pressed, ask Flutter to focus our text field using
  // myFocusNode.
  onPressed: () => FocusScope.of(context).requestFocus(myFocusNode),
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Text Field Focus',
      home: new MyForm(),
    );
  }
}

// Define a Custom Form Widget
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => new _MyFormState();
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class _MyFormState extends State<MyForm> {
  // Create the focus node. We will pass it to the TextField below.
  final FocusNode myFocusNode = new FocusNode();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Text Field Focus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: [
            // The first text field will be focused as soon as the app starts
            new TextField(
              autofocus: true,
            ),
            // The second text field will be focused when a user taps on the
            // FloatingActionButton
            new TextField(
              focusNode: myFocusNode,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        // When the button is pressed, ask Flutter to focus our text field using
        // myFocusNode.
        onPressed: () => FocusScope.of(context).requestFocus(myFocusNode),
        tooltip: 'Focus Second Text Field',
        child: new Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

![Text Field Focus Demo](/images/cookbook/focus.gif)
