---
title: "Persistent storage architecture: SQL"
description: Create a service to store complex data with SQL
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="app-architecture/todo_data_service"?>

Most Flutter applications, no matter how small or big they are, may require storing data on the user’s device at some point. For example, API keys, user preferences or data that should be available offline.

In this recipe, you will learn how to integrate persistent storage for complex data using SQL in a Flutter application following the Flutter Architecture design pattern.

To learn how to store simpler key-value data, take a look at the Cookbook recipe: Persistent Storage Architecture: Key-Value Data.

To read this recipe, you should be familiar with SQL and SQLite. If you need help, you can read the Persist data with SQLite recipe before reading this one.

This example uses sqflite with the sqflite_common_ffi plugin, which combined support mobile and desktop. Support for web is provided in the experimental plugin sqflite_common_ffi_web but it is not included in this example.

## Example application: ToDo list application

The example application consists of a single screen with an app bar at the top, a list of items, and a text field input at the bottom.

<picture>

The body of the application contains the TodoListScreen. This screen contains a ListView of ListTile items, each one representing a ToDo item. At the bottom, a TextField allows users to create new ToDo items by writing the task description and then tapping on the “Add” FilledButton.

Users can tap on the delete IconButton to delete the ToDo item. 

The list of ToDo items is stored locally using a database service, and restored when the user starts the application.

## Storing complex data with SQL

This functionality follows the recommended Flutter Architecture design, containing a UI layer and a data layer. Additionally, in the domain layer you will find the data model used.

- Presentation layer with TodoListScreen and TodoListViewModel.
- Domain layer with Todo data class.
- Data layer with TodoRepository and DatabaseService.

### ToDo list presentation layer

The TodoListScreen is a Widget that contains the UI in charge of displaying and creating the ToDo items. It follows the MVVM pattern and is accompanied by the TodoListViewModel, which contains the list of ToDo items and three Commands to load, add, and delete ToDo items.

This screen is divided into two parts, one containing the list of ToDo items, implemented using a ListView, and the other is a TextField and a Button, used for creating new ToDo items.

The ListView is wrapped by a ListenableBuilder, which listens to changes in the TodoListViewModel, and shows a ListTile for each ToDo item.

<?code-excerpt "lib/ui/todo_list/widgets/todo_list_screen.dart (ListenableBuilder)"?>
```dart
child: ListenableBuilder(
  listenable: widget.viewModel,
  builder: (context, child) {
    return ListView.builder(
      itemCount: widget.viewModel.todos.length,
      itemBuilder: (context, index) {
        final todo = widget.viewModel.todos[index];
        return ListTile(
          title: Text(todo.task),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => widget.viewModel.delete.execute(todo.id),
          ),
        );
      },
    );
  },
),
```

