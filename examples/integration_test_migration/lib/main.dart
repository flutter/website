import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const PlantsApp());
}

class Plant {
  Plant(this.name, this.species);

  final String name;

  final String species;
}

class PlantsApp extends StatelessWidget {
  const PlantsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plants by common name',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const HomePage(title: 'Plants by common name'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Plant> _listOfPlants = [];
  Plant? _selectedPlant;

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  void _loadPlants() {
    DefaultAssetBundle.of(context)
        .loadString('assets/plants.json')
        .then((data) {
      setState(() {
        final jsonResult = jsonDecode(data);
        final birdsJson = jsonResult['plants'];
        for (final birdJson in birdsJson) {
          final name = birdJson['name'] as String;
          final species = birdJson['species'] as String;
          final plant = Plant(name, species);
          _listOfPlants.add(plant);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          ListOfPlantsWidget(
            plants: _listOfPlants,
            selectedPlant: _selectedPlant,
            onSelectPlant: (plant) {
              setState(() {
                _selectedPlant = plant;
              });
            },
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: DetailPlant(plant: _selectedPlant),
            ),
          ),
        ],
      ),
    );
  }
}

class ListOfPlantsWidget extends StatefulWidget {
  const ListOfPlantsWidget({
    super.key,
    required this.plants,
    required this.onSelectPlant,
    this.selectedPlant,
  });

  final List<Plant> plants;
  final Plant? selectedPlant;
  final Function(Plant selected) onSelectPlant;

  @override
  State<ListOfPlantsWidget> createState() => _ListOfPlantsWidgetState();
}

class _ListOfPlantsWidgetState extends State<ListOfPlantsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ListView.builder(
        key: const Key('listOfPlants'),
        itemCount: widget.plants.length,
        itemBuilder: (context, index) {
          var plant = widget.plants[index];
          return ListTile(
            key: Key(plant.name),
            title: Text(plant.name),
            tileColor: widget.selectedPlant?.name == plant.name
                ? Colors.black12
                : Colors.white,
            onTap: () {
              widget.onSelectPlant(plant);
            },
          );
        },
      ),
    );
  }
}

class DetailPlant extends StatelessWidget {
  const DetailPlant({
    super.key,
    this.plant,
  });

  final Plant? plant;

  @override
  Widget build(BuildContext context) {
    if (plant == null) {
      return const Center(
        child: Text('Please select a plant from the list.'),
      );
    }
    const textStyleLabel = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    const textStyleText = TextStyle(
      fontSize: 20,
    );
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Name:',
                style: textStyleLabel,
              ),
              const SizedBox(width: 16),
              Text(
                plant!.name,
                style: textStyleText,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Species:',
                style: textStyleLabel,
              ),
              const SizedBox(width: 16),
              Text(
                plant!.species,
                style: textStyleText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
