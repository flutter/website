// ignore_for_file: directives_ordering, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// #docregion imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
// #enddocregion imports

void main() async {
  // #docregion initializeApp
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // #enddocregion initializeApp

  // #docregion runApp
  runApp(Provider.value(value: FirebaseFirestore.instance, child: MyApp()));
  // #enddocregion runApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
