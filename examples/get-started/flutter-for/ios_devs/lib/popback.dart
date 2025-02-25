import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// Define the name of the route as a constant so that
// you can use it in the Navigator to push the route using
// its name, as well as use it to create the list of your app-routes.
const detailsPageRouteName = '/details';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a [CupertinoApp] that, by default,
    // has the look and feel of an iOS app.
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      // Define your routes using a Map where the keys
      // are the route names and the values are
      // a function that receives a BuildContext and returns
      // the corresponding Widget.
      routes: {detailsPageRouteName: (context) => const DetailsPage()},
    );
  }
}

// Create a class that holds each person's data.
@immutable
class Person {
  final String name;
  final int age;
  const Person({required this.name, required this.age});
}

// Next, create a list of 100 persons.
final mockPersons = Iterable.generate(
  100,
  (index) => Person(name: 'Person #${index + 1}', age: 10 + index),
);

// This stateless widget displays the list of persons
// that we get from the mockPersons list and allows the user
// to tap each person to see their details.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Pick a person'),
      ),
      child: Material(
        child: ListView.builder(
          itemCount: mockPersons.length,
          itemBuilder: (context, index) {
            final person = mockPersons.elementAt(index);
            final age = '${person.age} years old';
            return ListTile(
              title: Text(person.name),
              subtitle: Text(age),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // When a [ListTile] that represents a person is
                // tapped, push the [detailsPageRouteName] route
                // to the [Navigator] and pass the person's instance
                // to the route.
                Navigator.of(
                  context,
                ).pushNamed(detailsPageRouteName, arguments: person);
              },
            );
          },
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Person person = ModalRoute.of(context)?.settings.arguments as Person;
    final age = '${person.age} years old';
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(person.name)),
      child: SafeArea(
        child: Material(
          child: Column(
            children: [
              ListTile(title: Text(person.name), subtitle: Text(age)),
              // #docregion pop-back
              TextButton(
                onPressed: () {
                  // This code allows the
                  // view to pop back to its presenter.
                  Navigator.of(context).pop();
                },
                child: const Text('Pop back'),
              ),
              // #enddocregion pop-back
            ],
          ),
        ),
      ),
    );
  }
}
