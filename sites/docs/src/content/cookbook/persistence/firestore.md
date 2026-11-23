---
title: Persist data with Cloud Firestore
description: >-
  How to store, read, update, and delete documents in Cloud Firestore
  from a Flutter app, and listen for realtime updates.
---

<?code-excerpt path-base="cookbook/persistence/firestore/"?>

:::note
This guide uses the [`cloud_firestore`][] plugin,
which supports Android, iOS, web, macOS, and (in beta) Windows.
For the latest platform support, check out the
[Firebase plugin table][].
:::

[`cloud_firestore`]: {{site.pub-pkg}}/cloud_firestore
[Firebase plugin table]: {{site.firebase}}/docs/flutter/setup#available-plugins

If your app's data needs to live in the cloud, sync across devices,
and keep working when the network drops,
[Cloud Firestore][] is the recommended default.
Cloud Firestore is a NoSQL document database from Firebase that
stores data as documents organized into collections,
pushes changes to connected clients in realtime,
and caches data on the device so that reads and writes work offline.
To compare Cloud Firestore with on-device SQLite,
key-value storage, and Firebase SQL Connect, check out
[Choose a database for your Flutter app][].

[Cloud Firestore]: {{site.firebase}}/docs/firestore
[Choose a database for your Flutter app]: /data-and-backend/persistence/choose-a-database

This recipe demonstrates the basics of using `cloud_firestore`
to add, read, update, and delete data about various Dogs,
and to display a list that updates automatically when the data changes.
It uses the same `Dog` model as the [SQLite recipe][],
so you can compare the two approaches side by side.

[SQLite recipe]: /cookbook/persistence/sqlite

This recipe uses the following steps:

  1. Add the dependencies.
  2. Connect your app to Firebase.
  3. Define the `Dog` data model.
  4. Add a `Dog` to the collection.
  5. Read the list of dogs.
  6. Listen for realtime updates.
  7. Update a `Dog` in the collection.
  8. Delete a `Dog` from the collection.

## 1. Add the dependencies

To work with Cloud Firestore, add the `firebase_core` and
`cloud_firestore` packages.

  * The `firebase_core` package connects your app to a Firebase project.
  * The `cloud_firestore` package provides classes and functions to
    read and write Cloud Firestore data.

To add the packages as dependencies, run `flutter pub add`:

```console
$ flutter pub add firebase_core cloud_firestore
```

Make sure to import the packages in the file you'll be working in.

<?code-excerpt "lib/main.dart (imports)"?>
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';

import 'firebase_options.dart';
```

## 2. Connect your app to Firebase

Unlike a local database, Cloud Firestore needs a Firebase project
to store your data. If you haven't already connected your app to
Firebase, install the [Firebase CLI][] and the FlutterFire CLI,
then run `flutterfire configure` from the root of your project:

```console
$ dart pub global activate flutterfire_cli
$ flutterfire configure
```

This registers your app with a Firebase project and generates
`lib/firebase_options.dart`, which the import in the previous step
refers to. Then initialize Firebase before calling `runApp()`:

<?code-excerpt "lib/main.dart (initializeApp)"?>
```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

For a full walkthrough of the setup, including creating a Firebase
project and enabling Cloud Firestore in the Firebase console, refer to
[Connect a Flutter app to Firebase][] and the
[Cloud Firestore quickstart][].

[Firebase CLI]: {{site.firebase}}/docs/cli
[Connect a Flutter app to Firebase]: /data-and-backend/firebase#connect-a-flutter-app-to-firebase
[Cloud Firestore quickstart]: {{site.firebase}}/docs/firestore/quickstart

## 3. Define the Dog data model

Before writing data, define the data that needs to be stored.
For this example, define a `Dog` class that contains three pieces of data:
a unique `id`, the `name`, and the `age` of each dog.

Cloud Firestore stores each dog as a *document* in a `dogs` *collection*.
A document is a set of named fields, similar to a `Map`,
and every document has a string ID.
Because the ID is part of the document's path rather than a field,
the `Dog` class converts to and from Firestore in two steps:

  * `toFirestore()` returns the `name` and `age` fields to write.
  * `Dog.fromFirestore()` reads those fields from a document snapshot
    and takes the `id` from the document itself.

<?code-excerpt "lib/main.dart (dog)"?>
```dart
class Dog {
  // Firestore document IDs are strings.
  final String id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});

  // Create a Dog from a Firestore document.
  // The document ID becomes the dog's id.
  factory Dog.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Dog(
      id: doc.id,
      name: data['name'] as String,
      age: data['age'] as int,
    );
  }

  // Convert a Dog into a Map. The keys become field names in Firestore.
  // The id isn't included because it's the document ID, not a field.
  Map<String, Object?> toFirestore() {
    return {'name': name, 'age': age};
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
```

:::tip
For larger models, `cloud_firestore` can convert documents to and
from your classes automatically with `withConverter()`.
To learn more, check out [Typing CollectionReference and DocumentReference][].
:::

[Typing CollectionReference and DocumentReference]: {{site.firebase}}/docs/firestore/query-data/get-data#custom_objects

## 4. Add a Dog to the collection

Get a reference to the `dogs` collection.
You don't need to create the collection ahead of time;
Cloud Firestore creates it the first time you write a document to it.

<?code-excerpt "lib/main.dart (collection)"?>
```dart
// A reference to the `dogs` collection.
// Firestore creates the collection the first time you write to it.
final CollectionReference<Map<String, dynamic>> dogs = FirebaseFirestore
    .instance
    .collection('dogs');
```

To add a dog, call [`add()`][] on the collection with the fields
to store. Cloud Firestore generates a unique document ID for you.

<?code-excerpt "lib/main.dart (addDog)"?>
```dart
// Add a new dog. Firestore generates a unique document ID.
Future<void> addDog(String name, int age) async {
  await dogs.add({'name': name, 'age': age});
}
```

If you need to choose the ID yourself, call `dogs.doc(id).set(...)`
instead.

[`add()`]: {{site.pub-api}}/cloud_firestore/latest/cloud_firestore/CollectionReference/add.html

## 5. Read the list of dogs

To read the collection once, call [`get()`][].
It returns a `QuerySnapshot` containing a document snapshot for
each dog, which you can convert into `Dog` objects.

<?code-excerpt "lib/main.dart (getDogs)"?>
```dart
// Read the dogs collection once.
Future<List<Dog>> getDogs() async {
  final snapshot = await dogs.get();
  return [for (final doc in snapshot.docs) Dog.fromFirestore(doc)];
}
```

[`get()`]: {{site.pub-api}}/cloud_firestore/latest/cloud_firestore/Query/get.html

## 6. Listen for realtime updates

Reading once is useful, but the main advantage of Cloud Firestore
over a local database is that it can push changes to your app
as they happen, whether they come from this device, another device,
or your backend.

To listen to a collection, call [`snapshots()`][] instead of `get()`.
It returns a `Stream` that emits a new `QuerySnapshot` every time
a matching document is added, changed, or removed.
You can also sort or filter the results with query methods
such as `orderBy()` and `where()` before listening.

<?code-excerpt "lib/main.dart (watchDogs)"?>
```dart
// Listen to the dogs collection.
// The stream emits a new list whenever any dog changes.
Stream<List<Dog>> watchDogs() {
  return dogs
      .orderBy('name')
      .snapshots()
      .map(
        (snapshot) => [for (final doc in snapshot.docs) Dog.fromFirestore(doc)],
      );
}
```

In a widget, pass the stream to a `StreamBuilder` to rebuild the UI
whenever new data arrives. Create the stream once, outside `build()`,
so that the widget doesn't resubscribe on every rebuild.

<?code-excerpt "lib/main.dart (ui)"?>
```dart
class DogListScreen extends StatefulWidget {
  const DogListScreen({super.key});

  @override
  State<DogListScreen> createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  // Create the stream once so that it isn't recreated on every rebuild.
  final Stream<List<Dog>> _dogsStream = watchDogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dogs')),
      body: StreamBuilder<List<Dog>>(
        stream: _dogsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final dogs = snapshot.data!;
          return ListView.builder(
            itemCount: dogs.length,
            itemBuilder: (context, index) {
              final dog = dogs[index];
              return ListTile(
                title: Text(dog.name),
                subtitle: Text('Age: ${dog.age}'),
                // Tap a dog to make it a year older.
                onTap: () => updateDog(
                  Dog(id: dog.id, name: dog.name, age: dog.age + 1),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteDog(dog.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDog('Fido', 35),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

[`snapshots()`]: {{site.pub-api}}/cloud_firestore/latest/cloud_firestore/Query/snapshots.html

## 7. Update a Dog in the collection

To change an existing dog, get a reference to its document with
`doc()` and call [`update()`][] with the fields to change.
Fields you don't include are left as they are.

<?code-excerpt "lib/main.dart (updateDog)"?>
```dart
// Update the fields of an existing dog.
Future<void> updateDog(Dog dog) async {
  await dogs.doc(dog.id).update(dog.toFirestore());
}
```

[`update()`]: {{site.pub-api}}/cloud_firestore/latest/cloud_firestore/DocumentReference/update.html

## 8. Delete a Dog from the collection

To remove a dog, get a reference to its document and call
[`delete()`][].

<?code-excerpt "lib/main.dart (deleteDog)"?>
```dart
// Delete a dog by its document ID.
Future<void> deleteDog(String id) async {
  await dogs.doc(id).delete();
}
```

[`delete()`]: {{site.pub-api}}/cloud_firestore/latest/cloud_firestore/DocumentReference/delete.html

## Work offline

On Android and Apple platforms, Cloud Firestore caches the documents
your app reads and queues any writes you make while offline.
The code in this recipe works without a network connection:
`snapshots()` keeps emitting from the local cache, and
`add()`, `update()`, and `delete()` sync to the server when
connectivity returns. Offline persistence is off by default on the web
and can be enabled with a setting. To learn more, check out
[Access data offline][].

[Access data offline]: {{site.firebase}}/docs/firestore/manage-data/enable-offline

## Secure your data

:::warning
If you created your database in **test mode** in the Firebase console,
anyone can read and write it, and the rules expire after 30 days.
Before you ship, write [Cloud Firestore Security Rules][] that
restrict access, typically by requiring users to sign in with
[Firebase Authentication][].
:::

[Cloud Firestore Security Rules]: {{site.firebase}}/docs/firestore/security/get-started
[Firebase Authentication]: /data-and-backend/firebase#authenticate-users-with-firebase-authentication

## Complete example

The following app shows all the pieces together: it connects to
Firebase, displays a live list of dogs, and lets you add,
update, and delete them.

<?code-excerpt "lib/main.dart"?>
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DogApp());
}

// A reference to the `dogs` collection.
// Firestore creates the collection the first time you write to it.
final CollectionReference<Map<String, dynamic>> dogs = FirebaseFirestore
    .instance
    .collection('dogs');

// Add a new dog. Firestore generates a unique document ID.
Future<void> addDog(String name, int age) async {
  await dogs.add({'name': name, 'age': age});
}

// Read the dogs collection once.
Future<List<Dog>> getDogs() async {
  final snapshot = await dogs.get();
  return [for (final doc in snapshot.docs) Dog.fromFirestore(doc)];
}

// Listen to the dogs collection.
// The stream emits a new list whenever any dog changes.
Stream<List<Dog>> watchDogs() {
  return dogs
      .orderBy('name')
      .snapshots()
      .map(
        (snapshot) => [for (final doc in snapshot.docs) Dog.fromFirestore(doc)],
      );
}

// Update the fields of an existing dog.
Future<void> updateDog(Dog dog) async {
  await dogs.doc(dog.id).update(dog.toFirestore());
}

// Delete a dog by its document ID.
Future<void> deleteDog(String id) async {
  await dogs.doc(id).delete();
}

class Dog {
  // Firestore document IDs are strings.
  final String id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});

  // Create a Dog from a Firestore document.
  // The document ID becomes the dog's id.
  factory Dog.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Dog(
      id: doc.id,
      name: data['name'] as String,
      age: data['age'] as int,
    );
  }

  // Convert a Dog into a Map. The keys become field names in Firestore.
  // The id isn't included because it's the document ID, not a field.
  Map<String, Object?> toFirestore() {
    return {'name': name, 'age': age};
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class DogApp extends StatelessWidget {
  const DogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: DogListScreen());
  }
}

class DogListScreen extends StatefulWidget {
  const DogListScreen({super.key});

  @override
  State<DogListScreen> createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  // Create the stream once so that it isn't recreated on every rebuild.
  final Stream<List<Dog>> _dogsStream = watchDogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dogs')),
      body: StreamBuilder<List<Dog>>(
        stream: _dogsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final dogs = snapshot.data!;
          return ListView.builder(
            itemCount: dogs.length,
            itemBuilder: (context, index) {
              final dog = dogs[index];
              return ListTile(
                title: Text(dog.name),
                subtitle: Text('Age: ${dog.age}'),
                // Tap a dog to make it a year older.
                onTap: () => updateDog(
                  Dog(id: dog.id, name: dog.name, age: dog.age + 1),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteDog(dog.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDog('Fido', 35),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```
