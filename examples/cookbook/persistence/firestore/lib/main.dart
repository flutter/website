// #docregion imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';

import 'firebase_options.dart';

// #enddocregion imports

void main() async {
  // #docregion initializeApp
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // #enddocregion initializeApp
  runApp(const DogApp());
}

// #docregion collection
// A reference to the `dogs` collection.
// Firestore creates the collection the first time you write to it.
final CollectionReference<Map<String, dynamic>> dogs = FirebaseFirestore
    .instance
    .collection('dogs');
// #enddocregion collection

// #docregion addDog
// Add a new dog. Firestore generates a unique document ID.
Future<void> addDog(String name, int age) async {
  await dogs.add({'name': name, 'age': age});
}
// #enddocregion addDog

// #docregion getDogs
// Read the dogs collection once.
Future<List<Dog>> getDogs() async {
  final snapshot = await dogs.get();
  return [for (final doc in snapshot.docs) Dog.fromFirestore(doc)];
}
// #enddocregion getDogs

// #docregion watchDogs
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
// #enddocregion watchDogs

// #docregion updateDog
// Update the fields of an existing dog.
Future<void> updateDog(Dog dog) async {
  await dogs.doc(dog.id).update(dog.toFirestore());
}
// #enddocregion updateDog

// #docregion deleteDog
// Delete a dog by its document ID.
Future<void> deleteDog(String id) async {
  await dogs.doc(id).delete();
}
// #enddocregion deleteDog

// #docregion dog
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
// #enddocregion dog

class DogApp extends StatelessWidget {
  const DogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: DogListScreen());
  }
}

// #docregion ui
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
// #enddocregion ui
