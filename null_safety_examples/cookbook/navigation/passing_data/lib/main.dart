import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// #docregion Todo
class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}
// #enddocregion Todo

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodosScreen(
      // #docregion Generate
      todos: List.generate(
        20,
        (i) => Todo(
          'Todo $i',
          'A description of what needs to be done for Todo $i',
        ),
      ),
      // #enddocregion Generate
    ),
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      // #docregion builder
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
      // #enddocregion builder
    );
  }
}

// #docregion detail
class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Todo todo;

  // In the constructor, require a Todo.
  DetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
// #enddocregion detail
