import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // #docregion TestWidgetStep2
  testWidgets('Add and remove a todo', (tester) async {
    // Build the widget
    await tester.pumpWidget(const TodoList());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');
  });
  // #enddocregion TestWidgetStep2

  // #docregion TestWidgetStep3
  testWidgets('Add and remove a todo', (tester) async {
    // Enter text code...

    // Tap the add button.
    await tester.tap(find.byType(FloatingActionButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to find the item on screen.
    expect(find.text('hi'), findsOneWidget);
  });
  // #enddocregion TestWidgetStep3

  // #docregion TestWidgetStep4
  testWidgets('Add and remove a todo', (tester) async {
    // Enter text and add the item...

    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), const Offset(500, 0));

    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Ensure that the item is no longer on screen.
    expect(find.text('hi'), findsNothing);
  });
  // #enddocregion TestWidgetStep4
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
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
        appBar: AppBar(title: const Text(_appTitle)),
        body: Column(
          children: [
            TextField(controller: controller),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: Text(todo)),
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
