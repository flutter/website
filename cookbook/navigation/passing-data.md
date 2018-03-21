---
layout: page
title: "Send data to a new screen"
permalink: /cookbook/navigation/passing-data/
---

Oftentimes, we not only want to navigate to a new screen, but also pass some
data to the screen as well. For example, we often want to pass information about 
the item we tapped on.

Remember: Screens are Just Widgets&trade;. In this example, we'll create a List 
of Todos. When a todo is tapped on, we'll navigate to a new screen (Widget) that
displays information about the todo.

## Directions

  1. Define a Todo class
  2. Display a List of Todos
  3. Create a Detail Screen that can display information about a todo
  4. Navigate and pass data to the Detail Screen

## 1. Define a Todo class

First, we'll need a simple way to represent Todos. For this example, we'll 
create a class that contains two pieces of data: the title and description.

```dart
class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}
```

## 2. Create a List of Todos

Second, we'll want to display a list of Todos. In this example, we'll generate
20 todos and show them using a ListView. For more information on working with
Lists, please see the [`Basic List`](/cookbook/lists/basic-list/) recipe.

### Generate the List of Todos

```dart
final todos = new List<Todo>.generate(
  20,
  (i) => new Todo(
        'Todo $i',
        'A description of what needs to be done for Todo $i',
      ),
);
```

### Display the List of Todos using a ListView

```dart
new ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return new ListTile(
      title: new Text(todos[index].title),
    );
  },
);
```

So far, so good. We'll generate 20 Todos and display them in a ListView!

## 3. Create a Detail Screen that can display information about a todo

Now, we'll create our second screen. The title of the screen will contain the
title of the todo, and the body of the screen will show the description.

Since it's a normal `StatelessWidget`, we'll simply require that users creating 
the Screen pass through a `Todo`! Then, we'll build a UI using the given Todo.

```dart
class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo
  final Todo todo;

  // In the constructor, require a Todo
  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${todo.title}"),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Text('${todo.description}'),
      ),
    );
  }
}
``` 

## 4. Navigate and pass data to the Detail Screen

With our `DetailScreen` in place, we're ready to perform the Navigation! In our 
case, we'll want to Navigate to the `DetailScreen` when a user taps on a Todo in 
our List. When we do so, we'll also want to pass the Todo to the `DetailScreen`.  

To achieve this, we'll write an [`onTap`](https://docs.flutter.io/flutter/material/ListTile/onTap.html) 
callback for our `ListTile` Widget. Within our `onTap` callback, we'll once 
again employ the [`Navigator.push`](https://docs.flutter.io/flutter/widgets/Navigator/push.html)
method. 

```dart
new ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return new ListTile(
      title: new Text(todos[index].title),
      // When a user taps on the ListTile, navigate to the DetailScreen.
      // Notice that we're not only creating a new DetailScreen, we're
      // also passing the current todo to it!
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new DetailScreen(todo: todos[index]),
          ),
        );
      },
    );
  },
);
```      

## Complete Example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  runApp(new MaterialApp(
    title: 'Passing Data',
    home: new TodosScreen(
      todos: new List.generate(
        20,
        (i) => new Todo(
              'Todo $i',
              'A description of what needs to be done for Todo $i',
            ),
      ),
    ),
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todos'),
      ),
      body: new ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return new ListTile(
            title: new Text(todos[index].title),
            // When a user taps on the ListTile, navigate to the DetailScreen.
            // Notice that we're not only creating a new DetailScreen, we're
            // also passing the current todo through to it!
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo
  final Todo todo;

  // In the constructor, require a Todo
  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${todo.title}"),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Text('${todo.description}'),
      ),
    );
  }
}
```

![Passing Data Demo](/images/cookbook/passing-data.gif)