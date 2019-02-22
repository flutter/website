---
title: Persist data with SQLite
prev:
  title: Working with WebSockets
  path: /docs/cookbook/networking/web-sockets
next:
  title: Reading and Writing Files
  path: /docs/cookbook/persistence/reading-writing-files
---

If you write an app that needs to persist and query larger amounts of data on
the local device, consider using a database instead of a local file or key-value
store. In general, databases provide faster inserts, updates, and queries
compared to other local persistence solutions.

Flutter apps can make use of the SQLite databases via the
[`sqflite`](https://pub.dartlang.org/packages/sqflite) plugin available on pub.
This recipe demonstrates the basics of using `sqflite` to insert, read, update,
and remove data about various Dogs!

If you are new to SQLite and SQL statements, please review the [SQLite Tutorial
site](http://www.sqlitetutorial.net/) to learn the basics before completing
this recipe.

## Directions

  1. Add the dependencies
  2. Define the `Dog` data model
  3. Open the Database
  4. Create the `dogs` table
  5. Insert a `Dog` into the database
  6. Retrieve the list of Dogs
  7. Update a `Dog` in the database
  7. Delete a `Dog` from the database

## 1. Add the dependencies

To work with SQLite databases, import the `sqflite` and `path` packages. 

  - The `sqflite` package provides classes and functions that allow you to
  interact with a SQLite database. 
  - The `path` package provides functions that allow you to correctly define the
  location to store the database on disk.

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite:
  path:
```

## 2. Define the Dog data model

Before you create the table to store information on Dogs, take a few moments to
define the data that needs to be stored. For this example, define a Dog class
that contains three pieces of data: A unique `id`, the `name`, and the `age` of
each dog.

<!-- skip -->
```dart
class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});
}
``` 

## 3. Open the Database

Before you read and write data to the database, you need to open a connection 
to the database. This involves two steps:

  1. Define the path to the database file using the `getDatabasesPath` from the
  `sqflite` package combined with the `path` function from the `path` package
  2. Open the database with the `openDatabase` function from `sqflite`

<!-- skip -->
```dart
// Open the database and store the reference
final Future<Database> database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'doggie_database.db'),
);
```

## 4. Create the `dogs` table

Next, you need to create a table to store information about various Dogs. For
this example, create a table called `dogs` that defines the data that can be
stored. In this case, each `Dog` contains an `id`, `name`, and `age`. Therefore,
these will be represented as three columns in the `dogs` table.

  1. The `id` is a Dart `int`, and will be stored as an `INTEGER` SQLite
  Datatype. It is also good practice to use an `id` as the primary key for the
  table to improve query and update times.
  2. The `name` is a Dart `String`, and will be stored as a `TEXT` SQLite
  Datatype
  3. The `age` is also a Dart `int`, and will be stored as an `INTEGER`
  Datatype

For more information about the available Datatypes that can be stored in a
SQLite database, please see [the official SQLite Datatypes
documentation](https://www.sqlite.org/datatype3.html).

<!-- skip -->
```dart
final Future<Database> database = openDatabase(
  // Set the path to the database. 
  join(await getDatabasesPath(), 'doggie_database.db'),
  // When the database is first created, create a table to store dogs
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database
    return db.execute(
      "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);
``` 

## 5. Insert a Dog into the database

Now that you have a database with a table suitable for storing information 
about various dogs, it's time to read and write data!

First, insert a `Dog` into the `dogs` table. This involves two steps:

  1. Convert the `Dog` into a `Map`
  2. Use the
  [`insert`](https://pub.dartlang.org/documentation/sqflite/latest/sqlite_api/DatabaseExecutor/insert.html)
  method to store the `Map` in the `dogs` table

<!-- skip -->
```dart
// First, update the Dog class to include a `toMap` method.
class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  // Convert the dog into a Map. The keys must correspond to the names of the 
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}

// Next, define a function that inserts dogs into the database
Future<void> insertDog(Dog dog) async {
  // Get a reference to the database
  final Database db = await database;

  // Insert the Dog into the correct table. You may also specify the 
  // `conflictAlgorithm` to use in case the same dog is inserted twice. 
  // 
  // In this case, replace any previous data.
  await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Now, you can create a Dog to and add it to the dogs table!
final fido = Dog(
  id: 0, 
  name: 'Fido', 
  age: 35,
);

await insertDog(fido);
```

## 6. Retrieve the list of Dogs

Now that you have a `Dog` stored in the database, you can query the database
for a specific dog or a list of all dogs! This involves two steps:

  1. Run a `query` against the `dogs` table. This will return a `List<Map>`
  2. Convert the `List<Map>` into a `List<Dog>` 
  
<!-- skip -->
```dart
// A method that will retrieve all the dogs from the dogs table
Future<List<Dog>> dogs() async {
  // Get a reference to the database
  final Database db = await database;

  // Query the table for All The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('dogs');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Dog(
      id: maps[i]['id'],
      name: maps[i]['name'],
      age: maps[i]['age'],
    );
  });
}

// Now, you can use the method above to retrieve all the dogs!
print(await dogs()); // Prints a list that include Fido
```

## 7. Update a `Dog` in the database

After you've inserted some information into the database, you may want to update
that information at a later time. To do so, use the
[`update`](https://pub.dartlang.org/documentation/sqflite/latest/sqlite_api/DatabaseExecutor/update.html)
method from the `sqflite` library.

This involves two steps:

  1. Convert the Dog into a Map
  2. Use a `where` clause to ensure you update the correct Dog

<!-- skip -->
```dart
Future<void> updateDog(Dog dog) async {
  // Get a reference to the database
  final db = await database;

  // Update the given Dog
  await db.update(
    'dogs',
    dog.toMap(),
    // Ensure we only update the Dog with a matching id
    where: "id = ${dog.id}",
  );
}

// Now, you can update Fido's age!
await updateDog(Dog(
  id: 0, 
  name: 'Fido', 
  age: 42,
));

// And you could print the updated results
print(await dogs()); // Prints Fido with age 42.
```

## 8. Delete a `Dog` from the database

In addition to inserting and updating information about Dogs, you can also
remove dogs from the database. To delete data, use the
[`delete`](https://pub.dartlang.org/documentation/sqflite/latest/sqlite_api/DatabaseExecutor/delete.html)
method from the `sqflite` library. 

In this portion, create a function that takes in an id and deletes the dog with
a matching id from the database. To make this work, you must provide a `where`
clause to limit the records being deleted.

<!-- skip -->
```dart
Future<void> deleteDog(int id) async {
  // Get a reference to the database
  final db = await database;

  // Remove the Dog from the Database
  await db.delete(
    'dogs',
    // Use a `where` clause to delete a specific dog
    where: "id = $id",
  );
}
```

## Example

To run the example:

  1. Create a new Flutter project
  2. Add the `sqfite` and `path` packages to your `pubspec.yaml`
  3. Paste the following code into a new file called `lib/db_test.dart`
  4. Run the code with `flutter run lib/db_test.dart`

```dart
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database
    final Database db = await database;

    // Insert the Dog into the correct table. We will also specify the
    // `conflictAlgorithm` to use in this case. If the same dog is inserted
    // multiple times, it will replace the previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    // Get a reference to the database
    final Database db = await database;

    // Query the table for All The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database
    final db = await database;

    // Update the given Dog
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure we only update the Dog with a matching id
      where: "id = ${dog.id}",
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database
    final db = await database;

    // Remove the Dog from the Database
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog
      where: "id = $id",
    );
  }

  var fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  // Insert a dog into the database
  await insertDog(fido);

  // Print the list of dogs (only Fido for now)
  print(await dogs());

  // Update Fido's age and save it to the database
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  // Print Fido's updated information
  print(await dogs());

  // Delete Fido from the Database
  await deleteDog(fido.id);

  // Print the list of dogs (empty)
  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about each dog when
  // using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
```

