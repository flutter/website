import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

// #docregion routes
// Defines the route name as a constant
// so that it's reusable.
const detailsPageRouteName = '/details';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const HomePage(),
      // The [routes] property defines the available named routes
      // and the widgets to build when navigating to those routes.
      routes: {
        detailsPageRouteName: (context) => const DetailsPage(),
      },
    );
  }
}
// #enddocregion routes

// Create a class that holds each person's data.
@immutable
class Person {
  final String name;
  final int age;
  const Person({
    required this.name,
    required this.age,
  });
}

// Next, create a list of 100 Persons.
final mockPersons = Iterable.generate(
  100,
  (index) => Person(
    name: 'Person #${index + 1}',
    age: 10 + index,
  ),
);

// This stateless widget displays the list of persons
// that we get from the [mockPersons] list and allows the user
// to tap each person to see their details.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Pick a person',
        ),
      ),
      child: Material(
        // #docregion list-view
        child: ListView.builder(
          itemCount: mockPersons.length,
          itemBuilder: (context, index) {
            final person = mockPersons.elementAt(index);
            final age = '${person.age} years old';
            return ListTile(
              title: Text(person.name),
              subtitle: Text(age),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                // When a [ListTile] that represents a person is
                // tapped, push the detailsPageRouteName route
                // to the Navigator and pass the person's instance
                // to the route.
                Navigator.of(context).pushNamed(
                  detailsPageRouteName,
                  arguments: person,
                );
              },
            );
          },
        ),
        // #enddocregion list-view
      ),
    );
  }
}

// #docregion details-page
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Read the person instance from the arguments.
    final Person person = ModalRoute.of(
      context,
    )?.settings.arguments as Person;
    // Extract the age.
    final age = '${person.age} years old';
    return Scaffold(
      // Display name and age.
      body: Column(children: [Text(person.name), Text(age)]),
    );
  }
}
// #enddocregion details-page
