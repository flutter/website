import 'package:flutter/material.dart';

void main() {
  runApp(const BirdsApp());
}

class Bird {
  Bird(this.family, this.members);

  final String family;

  final List<String> members;
}

class BirdsApp extends StatelessWidget {
  const BirdsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birds of Antartica',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const HomePage(title: 'Birds of Antartica'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Bird? _selectedBird;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          const ListOfBirdsWidget(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: DetailBird(bird: _selectedBird),
            ),
          ),
        ],
      ),
    );
  }
}

class ListOfBirdsWidget extends StatefulWidget {
  const ListOfBirdsWidget({Key? key}) : super(key: key);

  @override
  _ListOfBirdsWidgetState createState() => _ListOfBirdsWidgetState();
}

class _ListOfBirdsWidgetState extends State<ListOfBirdsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
    );
  }
}

class DetailBird extends StatelessWidget {
  const DetailBird({
    Key? key,
    this.bird,
  }) : super(key: key);

  final Bird? bird;

  @override
  Widget build(BuildContext context) {
    if (bird == null) {
      return const Center(
        child: Text('Please select a bird from the list.'),
      );
    }
    return Container();
  }
}
