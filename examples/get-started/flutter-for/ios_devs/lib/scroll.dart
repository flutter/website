import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: HomePage(),
    );
  }
}

// create a class that holds each person's data
@immutable
class Person {
  final String name;
  final int age;
  const Person({
    required this.name,
    required this.age,
  });
}

// As in SwiftUI, create a widget (a view in SwiftUI),
// that represents each person visually on the screen.
class PersonView extends StatelessWidget {
  final Person person;
  const PersonView({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Name:'),
            Text(person.name),
          ],
        ),
        Row(
          children: [
            const Text('Age:'),
            Text(person.age.toString()),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

// then we create a list of people
final mockPersons = Iterable.generate(
  100,
  (index) => Person(
    name: 'Person #${index + 1}',
    age: 10 + index,
  ),
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Finally, display the list of people on the screen,
      // inside a scroll view of type
      // SingleChildScrollView (equivalent of a ScrollView in SwiftUI).
      // #docregion scroll-example
      body: SingleChildScrollView(
        child: Column(
          children: mockPersons
              .map(
                (person) => PersonView(
                  person: person,
                ),
              )
              .toList(),
        ),
      ),
      // #enddocregion scroll-example
    );
  }
}
