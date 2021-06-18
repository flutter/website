---
title: Tap, drag, and enter text
description: How to test widgets for user interaction.
prev:
  title: Find widgets
  path: /docs/cookbook/testing/widget/finders
---

<?code-excerpt path-base="../null_safety_examples/cookbook/testing/widget/tap_drag/"?>

{% assign api = site.api | append: '/flutter' -%}

Many widgets not only display information, but also respond
to user interaction. This includes buttons that can be tapped,
and [`TextField`][] for entering text.

To test these interactions, you need a way to simulate them
in the test environment. For this purpose, use the
[`WidgetTester`][] library.

The `WidgetTester` provides methods for entering text,
tapping, and dragging.

* [`enterText()`][]
* [`tap()`][]
* [`drag()`][]

In many cases, user interactions update the state of the app. In the test
environment, Flutter doesn't automatically rebuild widgets when the state
changes. To ensure that the widget tree is rebuilt after simulating a user
interaction, call the [`pump()`][] or [`pumpAndSettle()`][]
methods provided by the `WidgetTester`.
This recipe uses the following steps:

  1. Create a widget to test.
  2. Enter text in the text field.
  3. Ensure tapping a button adds the todo.
  4. Ensure swipe-to-dismiss removes the todo.

### 1. Create a widget to test

For this example,
create a basic todo app that tests three features:

  1. Entering text into a `TextField`.
  2. Tapping a `FloatingActionButton` to add the text to a list of todos.
  3. Swiping-to-dismiss to remove the item from the list.

To keep the focus on testing,
this recipe won't provide a detailed guide on how to build the todo app.
To learn more about how this app is built,
see the relevant recipes:

* [Create and style a text field][]
* [Handle taps][]
* [Create a basic list][]
* [Implement swipe to dismiss][]

<?code-excerpt "test/main_test.dart (TodoList)"?>
```dart
class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    child: ListTile(title: Text(todo)),
                    background: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

### 2. Enter text in the text field

Now that you have a todo app, begin writing the test.
Start by entering text into the `TextField`.

Accomplish this task by:

  1. Building the widget in the test environment.
  2. Using the [`enterText()`][]
     method from the `WidgetTester`.

<!-- skip -->
```dart
testWidgets('Add and remove a todo', (WidgetTester tester) async {
  // Build the widget
  await tester.pumpWidget(const TodoList());

  // Enter 'hi' into the TextField.
  await tester.enterText(find.byType(TextField), 'hi');
});
```

{{site.alert.note}}
  This recipe builds upon previous widget testing recipes.
  To learn the core concepts of widget testing,
  see the following recipes:

* [Introduction to widget testing][]
* [Finding widgets in a widget test][]
{{site.alert.end}}

### 3. Ensure tapping a button adds the todo

After entering text into the `TextField`, ensure that tapping
the `FloatingActionButton` adds the item to the list.

This involves three steps:

 1. Tap the add button using the [`tap()`][] method.
 2. Rebuild the widget after the state has changed using the
    [`pump()`][] method.
 3. Ensure that the list item appears on screen.

<!-- skip -->
```dart
testWidgets('Add and remove a todo', (WidgetTester tester) async {
  // Enter text code...

  // Tap the add button.
  await tester.tap(find.byType(FloatingActionButton));

  // Rebuild the widget after the state has changed.
  await tester.pump();

  // Expect to find the item on screen.
  expect(find.text('hi'), findsOneWidget);
});
```

### 4. Ensure swipe-to-dismiss removes the todo

Finally, ensure that performing a swipe-to-dismiss action on the todo
item removes it from the list. This involves three steps:

  1. Use the [`drag()`][]
     method to perform a swipe-to-dismiss action.
  2. Use the [`pumpAndSettle()`][]
     method to continually rebuild the widget tree until the dismiss
     animation is complete.
  3. Ensure that the item no longer appears on screen.

<!-- skip -->
```dart
testWidgets('Add and remove a todo', (WidgetTester tester) async {
  // Enter text and add the item...

  // Swipe the item to dismiss it.
  await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));

  // Build the widget until the dismiss animation ends.
  await tester.pumpAndSettle();

  // Ensure that the item is no longer on screen.
  expect(find.text('hi'), findsNothing);
});
```

### Complete example

<?code-excerpt "test/main_test.dart"?>
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const TodoList());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');

    // Tap the add button.
    await tester.tap(find.byType(FloatingActionButton));

    // Rebuild the widget with the new item.
    await tester.pump();

    // Expect to find the item on screen.
    expect(find.text('hi'), findsOneWidget);

    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));

    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Ensure that the item is no longer on screen.
    expect(find.text('hi'), findsNothing);
  });
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    child: ListTile(title: Text(todo)),
                    background: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

[Create a basic list]: /docs/cookbook/lists/basic-list
[Create and style a text field]: /docs/cookbook/forms/text-input
[`drag()`]: {{api}}/flutter_test/WidgetController/drag.html
[`enterText()`]: {{api}}/flutter_test/WidgetTester/enterText.html
[Finding widgets in a widget test]: /docs/cookbook/testing/widget/finders
[Handle taps]: /docs/cookbook/gestures/handling-taps
[Implement swipe to dismiss]: /docs/cookbook/gestures/dismissible
[Introduction to widget testing]: /docs/cookbook/testing/widget/introduction
[`pump()`]: {{api}}/flutter_test/WidgetTester/pump.html
[`pumpAndSettle()`]: {{api}}/flutter_test/WidgetTester/pumpAndSettle.html
[`tap()`]: {{api}}/flutter_test/WidgetController/tap.html
[`TextField`]: {{api}}/material/TextField-class.html
[`WidgetTester`]: {{api}}/flutter_test/WidgetTester-class.html

