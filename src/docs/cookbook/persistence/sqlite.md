---
title: Persist data with SQLite
description: How to use SQLite to store and retrieve data.
prev:
  title: Work with WebSockets
  path: /docs/cookbook/networking/web-sockets
next:
  title: Read and write files
  path: /docs/cookbook/persistence/reading-writing-files
---

<?code-excerpt path-base="../null_safety_examples/cookbook/persistence/sqlite/"?>

If you are writing an app that needs to persist and query large amounts of data on
the local device, consider using a database instead of a local file or
key-value store. In general, databases provide faster inserts, updates,
and queries compared to other local persistence solutions.

Flutter apps can make use of the SQLite databases via the
[`sqflite`][] plugin available on pub.dev.
This recipe demonstrates the basics of using `sqflite`
to insert, read, update, and remove data about various Dogs.

If you are new to SQLite and SQL statements, review the
[SQLite Tutorial][] to learn the basics before
completing this recipe.

This recipe uses the following steps:

  1. Add the dependencies.
  2. Define the `Dog` data model.
  3. Open the database.
  4. Create the `dogs` table.
  5. Insert a `Dog` into the database.
  6. Retrieve the list of dogs.
  7. Update a `Dog` in the database.
  7. Delete a `Dog` from the database.

## 1. Add the dependencies

To work with SQLite databases, import the `sqflite` and `path` packages.

  * The `sqflite` package provides classes and functions to
    interact with a SQLite database.
  * The `path` package provides functions to
    define the location for storing the database on disk.

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite:
  path:
```

Make sure to import the packages in the file you'll be working in.

<!-- skip -->
```dart
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
```

## 2. Define the Dog data model

Before creating the table to store information on Dogs, take a few moments to
define the data that needs to be stored. For this example, define a Dog class
that contains three pieces of data:
A unique `id`, the `name`, and the `age` of each dog.

<?code-excerpt "lib/step2.dart"?>
```dart
class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });
}
```

## 3. Open the database

Before reading and writing data to the database, open a connection
to the database. This involves two steps:

  1. Define the path to the database file using `getDatabasesPath()` from the
  `sqflite` package, combined with the `join` function from the `path` package.
  2. Open the database with the `openDatabase()` function from `sqflite`.

{{site.alert.note}}
  In order to use the keyword `await`, the code must be placed
  inside an `async` function. You should place all the following
  table functions inside `void main() async {}`. 
{{site.alert.end}}

<?code-excerpt "lib/step3.dart (openDatabase)"?>
```dart
// Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
final database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'doggie_database.db'),
);
```

## 4. Create the `dogs` table

Next, create a table to store information about various Dogs.
For this example, create a table called `dogs` that defines the data
that can be stored. Each `Dog` contains an `id`, `name`, and `age`.
Therefore, these are represented as three columns in the `dogs` table.

  1. The `id` is a Dart `int`, and is stored as an `INTEGER` SQLite
     Datatype. It is also good practice to use an `id` as the primary
     key for the table to improve query and update times.
  2. The `name` is a Dart `String`, and is stored as a `TEXT` SQLite
     Datatype.
  3. The `age` is also a Dart `int`, and is stored as an `INTEGER`
     Datatype.

For more information about the available Datatypes that can be stored in a
SQLite database, see the [official SQLite Datatypes documentation][].

<?code-excerpt "lib/main.dart (openDatabase)"?>
```dart
final database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'doggie_database.db'),
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);
```

## 5. Insert a Dog into the database

Now that you have a database with a table suitable for storing information
about various dogs, it's time to read and write data.

First, insert a `Dog` into the `dogs` table. This involves two steps:

1. Convert the `Dog` into a `Map`
2. Use the [`insert()`][] method to store the
   `Map` in the `dogs` table.

<?code-excerpt "lib/main.dart (Dog)"?>
```dart
class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
```

<?code-excerpt "lib/main.dart (insertDog)"?>
```dart
// Define a function that inserts dogs into the database
Future<void> insertDog(Dog dog) async {
  // Get a reference to the database.
  final db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
```

<?code-excerpt "lib/main.dart (fido)"?>
```dart
// Create a Dog and add it to the dogs table
var fido = Dog(
  id: 0,
  name: 'Fido',
  age: 35,
);

await insertDog(fido);
```

## 6. Retrieve the list of Dogs

Now that a `Dog` is stored in the database, query the database
for a specific dog or a list of all dogs. This involves two steps:

  1. Run a `query` against the `dogs` table. This returns a `List<Map>`.
  2. Convert the `List<Map>` into a `List<Dog>`.

<?code-excerpt "lib/main.dart (dogs)"?>
```dart
// A method that retrieves all the dogs from the dogs table.
Future<List<Dog>> dogs() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
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
```

<?code-excerpt "lib/main.dart (print)"?>
```dart
// Now, use the method above to retrieve all the dogs.
print(await dogs()); // Prints a list that include Fido.
```

## 7. Update a `Dog` in the database

After inserting information into the database,
you might want to update that information at a later time.
You can do this by using the [`update()`][]
method from the `sqflite` library.

This involves two steps:

  1. Convert the Dog into a Map.
  2. Use a `where` clause to ensure you update the correct Dog.

<?code-excerpt "lib/main.dart (update)"?>
```dart
Future<void> updateDog(Dog dog) async {
  // Get a reference to the database.
  final db = await database;

  // Update the given Dog.
  await db.update(
    'dogs',
    dog.toMap(),
    // Ensure that the Dog has a matching id.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [dog.id],
  );
}
```

<?code-excerpt "lib/main.dart (update2)"?>
```dart
// Update Fido's age and save it to the database.
fido = Dog(
  id: fido.id,
  name: fido.name,
  age: fido.age + 7,
);
await updateDog(fido);

// Print the updated results.
print(await dogs()); // Prints Fido with age 42.
```

{{site.alert.warning}}
  Always use `whereArgs` to pass arguments to a `where` statement.
  This helps safeguard against SQL injection attacks.

  Do not use string interpolation, such as `where: "id = ${dog.id}"`!
{{site.alert.end}}


## 8. Delete a `Dog` from the database

In addition to inserting and updating information about Dogs,
you can also remove dogs from the database. To delete data,
use the [`delete()`][] method from the `sqflite` library.

In this section, create a function that takes an id and deletes the dog with
a matching id from the database. To make this work, you must provide a `where`
clause to limit the records being deleted.

<?code-excerpt "lib/main.dart (deleteDog)"?>
```dart
Future<void> deleteDog(int id) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Dog from the database.
  await db.delete(
    'dogs',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}
```

## Example

To run the example:

  1. Create a new Flutter project.
  2. Add the `sqflite` and `path` packages to your `pubspec.yaml`.
  3. Paste the following code into a new file called `lib/db_test.dart`.
  4. Run the code with `flutter run lib/db_test.dart`.

<?code-excerpt "lib/main.dart"?>
```dart
import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
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
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await dogs()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
```


[`delete()`]: {{site.pub-api}}/sqflite_common/latest/sqlite_api/DatabaseExecutor/delete.html
[`insert()`]: {{site.pub-api}}/sqflite_common/latest/sqlite_api/DatabaseExecutor/insert.html
[`sqflite`]: {{site.pub-pkg}}/sqflite
[SQLite Tutorial]: http://www.sqlitetutorial.net/
[official SQLite Datatypes documentation]: https://www.sqlite.org/datatype3.html
[`update()`]: {{site.pub-api}}/sqflite_common/latest/sqlite_api/DatabaseExecutor/update.html
