---
title: Tapping, dragging and entering text
prev:
  title: Finding widgets
  path: /docs/cookbook/testing/widget/finders
---

{% assign api = site.api | append: '/flutter' -%}

Many of the Widgets we build not only display information, but also respond to
user interaction. This includes buttons that users can tap on, dragging items
across the screen, or entering text into a
[`TextField`]({{api}}/material/TextField-class.html).

In order to test these interactions, we need a way to simulate them in the test
environment. To do so, we can use the
[`WidgetTester`]({{api}}/flutter_test/WidgetTester-class.html)
class provided by the
[`flutter_test`]({{api}}/flutter_test/flutter_test-library.html)
library.

The `WidgetTester` provides methods for entering text, tapping, and dragging.

  * [`enterText`]({{api}}/flutter_test/WidgetTester/enterText.html)
  * [`tap`]({{api}}/flutter_test/WidgetController/tap.html)
  * [`drag`]({{api}}/flutter_test/WidgetController/drag.html)

In many cases, user interactions will update the state of our app. In the test
environment, Flutter will not automatically rebuild widgets when the state
changes. To ensure our Widget tree is rebuilt after we simulate a user
interaction, we must call the
[`pump`]({{api}}/flutter_test/WidgetTester/pump.html) or
[`pumpAndSettle`]({{api}}/flutter_test/WidgetTester/pumpAndSettle.html)
methods provided by the `WidgetTester`.

### Directions

  1. Create a Widget to test
  2. Enter text in the text field
  3. Ensure tapping a button adds the todo
  4. Ensure swipe-to-dismiss removes the todo

### 1. Create a Widget to test

For this example, we'll create a basic todo app. It will have three main
features that we'll want to test:

  1. Enter text into a `TextField`
  2. Tapping a `FloatingActionButton` adds the text to a list of todos
  3. Swipe-to-dismiss removes the item from the list

To keep the focus on testing, this recipe will not provide a detailed guide on
how to build the todo app. To learn more about how this app is built, please see
the relevant recipes:

  * [Create and style a text field](/docs/cookbook/forms/text-input/)
  * [Handling Taps](/docs/cookbook/gestures/handling-taps/)
  * [Create a basic list](/docs/cookbook/lists/basic-list/)
  * [Implement Swipe to Dismiss](/docs/cookbook/gestures/dismissible/)

```dart
class TodoList extends StatefulWidget {
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
          title: Text(_appTitle),
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
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

### 2. Enter text in the text field

Now that we have a todo app, we can begin writing our test! In this case, we'll
start by entering text into the `TextField`.

We can accomplish this task by:

  1. Building the Widget in the Test Environment
  2. Using the
  [`enterText`]({{api}}/flutter_test/WidgetTester/enterText.html)
  method from the `WidgetTester`

<!-- skip -->
```dart
testWidgets('Add and remove a todo', (WidgetTester tester) async {
  // Build the Widget
  await tester.pumpWidget(TodoList());

  // Enter 'hi' into the TextField
  await tester.enterText(find.byType(TextField), 'hi');
});
```

**Note:** This recipe builds upon previous Widget testing recipes. To learn the
core concepts of Widget testing, see the following recipes:

  * [Introduction to Widget testing](.)
  * [Finding Widgets in a Widget Test](finders)

### 3. Ensure tapping a button adds the todo

After we've entered text into the `TextField`, we'll want to ensure that tapping
the `FloatingActionButton` adds the item to the list.

This will involve three steps:

 1. Tap the add button using the
    [`tap`]({{api}}/flutter_test/WidgetController/tap.html)
    method
 2. Rebuild the Widget after the state has changed using the
    [`pump`]({{api}}/flutter_test/TestWidgetsFlutterBinding/pump.html)
    method
 3. Ensure the list item appears on screen

<!-- skip -->
```dart
testWidgets('Add and remove a todo', (WidgetTester tester) async {
  // Enter text code...

  // Tap the add button
  await tester.tap(find.byType(FloatingActionButton));

  // Rebuild the Widget after the state has changed
  await tester.pump();

  // Expect to find the item on screen
  expect(find.text('hi'), findsOneWidget);
});
```

### 4. Ensure swipe-to-dismiss removes the todo

Finally, we can ensure that performing a swipe-to-dismiss action on the todo
item will remove it from the list. This will involve three steps:

  1. Use the
  [`drag`]({{api}}/flutter_test/WidgetController/drag.html)
  method to perform a swipe-to-dismiss action.
  2. Use the
  [`pumpAndSettle`]({{api}}/flutter_test/WidgetTester/pumpAndSettle.html)
  method to continually rebuild our Widget tree until the dismiss animation is
  complete.
  3. Ensure the item no longer appears on screen.

<!-- skip -->
```dart
testWidgets('Add and remove a todo', (WidgetTester tester) async {
  // Enter text and add the item...

  // Swipe the item to dismiss it
  await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));

  // Build the Widget until the dismiss animation ends
  await tester.pumpAndSettle();

  // Ensure the item is no longer on screen
  expect(find.text('hi'), findsNothing);
});
```

### Complete example

Once we've completed these steps, we should have a working app with a test to
ensure it works correctly!

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    // Build the Widget
    await tester.pumpWidget(TodoList());

    // Enter 'hi' into the TextField
    await tester.enterText(find.byType(TextField), 'hi');

    // Tap the add button
    await tester.tap(find.byType(FloatingActionButton));

    // Rebuild the Widget with the new item
    await tester.pump();

    // Expect to find the item on screen
    expect(find.text('hi'), findsOneWidget);

    // Swipe the item to dismiss it
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));

    // Build the Widget until the dismiss animation ends
    await tester.pumpAndSettle();

    // Ensure the item is no longer on screen
    expect(find.text('hi'), findsNothing);
  });
}

class TodoList extends StatefulWidget {
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
          title: Text(_appTitle),
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
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```
