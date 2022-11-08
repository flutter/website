import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

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

// like in SwiftUI, we create a widget (view in SwiftUI),
// that represents each person visually on the screen
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
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // and last but not least, we display the list
      // of people on the screen inside a scroll viwe of type
      // SingleChildScrollView (equivalent of ScrollView in SwiftUI)
      body:
          // #docregion ScrollExample
          SingleChildScrollView(
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
      // #enddocregion ScrollExample
    );
  }
}
