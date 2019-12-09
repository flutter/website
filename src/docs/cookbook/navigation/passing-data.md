---
title: Send data to a new screen
prev:
  title: Return data from a screen
  path: /docs/cookbook/navigation/returning-data
next:
  title: Fetch data from the internet
  path: /docs/cookbook/networking/fetch-data
---

Often, you not only want to navigate to a new screen,
but also pass data to the screen as well.
For example, you might want to pass information about
the item that's been tapped.

Remember: Screens are just widgets.
In this example, create a list of todos.
When a todo is tapped, navigate to a new screen (widget) that
displays information about the todo.
This recipe uses the following steps:

  1. Define a todo class.
  2. Display a list of todos.
  3. Create a detail screen that can display information about a todo.
  4. Navigate and pass data to the detail screen.

## 1. Define a todo class

First, you need a simple way to represent todos. For this example,
create a class that contains two pieces of data: the title and description.

<!-- skip -->
```dart
class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}
```

## 2. Create a list of todos

Second, display a list of todos. In this example, generate
20 todos and show them using a ListView.
For more information on working with lists,
see the [Use lists][] recipe.

### Generate the list of todos

<!-- skip -->
```dart
final todos = List<Todo>.generate(
  20,
  (i) => Todo(
        'Todo $i',
        'A description of what needs to be done for Todo $i',
      ),
);
```

### Display the list of todos using a ListView

<!-- skip -->
```dart
ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(todos[index].title),
    );
  },
);
```

So far, so good.
This generates 20 todos and displays them in a ListView.

## 3. Create a detail screen to display information about a todo

Now, create the second screen. The title of the screen contains the
title of the todo, and the body of the screen shows the description.

Since the detail screen is a normal `StatelessWidget`,
require the user to enter a `Todo` in the UI.
Then, build the UI using the given todo.

<!-- skip -->
```dart
class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Todo todo;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo}) : super(key: key);

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
```

## 4. Navigate and pass data to the detail screen

With a `DetailScreen` in place,
you're ready to perform the Navigation.
In this example, navigate to the `DetailScreen` when a user
taps a todo in the list. Pass the todo to the `DetailScreen`.

To capture the user's tap, write an [`onTap()`][]
callback for the `ListTile` widget. Within the `onTap()` callback,
use the [`Navigator.push()`][] method.

<!-- skip -->
```dart
ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(todos[index].title),
      // When a user taps the ListTile, navigate to the DetailScreen.
      // Notice that you're not only creating a DetailScreen, you're
      // also passing the current todo to it.
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
);
```

### Complete example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodosScreen(
      todos: List.generate(
        20,
        (i) => Todo(
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
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
    );
  }
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Todo todo;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo}) : super(key: key);

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
```

## Alternatively, pass the arguments using RouteSettings

Repeat the first two steps.

### Create a detail screen to extract the arguments

Next, create a detail screen that extracts and displays the title and description from the `Todo`. To access the `Todo`, use the `ModalRoute.of()` method. This method returns the current route with the arguments.

```
class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;

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
```

### Navigate and pass the arguments to the detail screen

Finally, navigate to the `DetailScreen` when a user taps a `ListTile` widget using `Navigator.push()`. Pass the arguments as part of the `RouteSettings`. The `DetailScreen` extracts these arguments.

```
ListView.builder(                                                    
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
            builder: (context) => DetailScreen(),                    
            // Pass the arguments as part of the RouteSettings. The  
            // DetailScreen reads the arguments from these settings. 
            settings: RouteSettings(                                 
              arguments: todos[index],                               
            ),                                                        
          ),                                                          
        );                                                           
      },                                                             
    );                                                                
  },                                                                 
),                                                                                                                           
```

### Complete example

```
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodosScreen(
      todos: List.generate(
        20,
        (i) => Todo(
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
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
                  builder: (context) => DetailScreen(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(
                    arguments: todos[index],
                  ),
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
  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;

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
```

![Passing Data Demo](/images/cookbook/passing-data.gif){:.site-mobile-screenshot}


[`Navigator.push()`]: {{site.api}}/flutter/widgets/Navigator/push.html
[`onTap()`]: {{site.api}}/flutter/material/ListTile/onTap.html
[Use lists]: /docs/cookbook/lists/basic-list
