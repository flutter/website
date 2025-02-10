import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

// #docregion PreferredOrientations
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

// #enddocregion PreferredOrientations
