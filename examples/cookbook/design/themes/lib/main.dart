import 'package:flutter/material.dart';
//Import the font package
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Custom Themes';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          brightness: Brightness.dark,
          // TRY THIS: Change to "Brightness.light"
          //           and see that all colors change
          //           to better contrast a light background
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge:
              const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge:
              GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
          // TRY THIS: Change one of the GoogleFonts
          //           to "lato", "poppins", or "lora"
          //           The title uses "titleLarge"
          //           and the middle text uses "bodyMedium"
        ),
      ),
      home: const MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Simplifies later use of Theme context

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: theme.colorScheme.primary,
          child: Text(
            'Text with a background color',
            style: theme.textTheme.bodyMedium,
            // TRY THIS: Change the Text value
            //           or change the theme.textTheme
            //           to "displayLarge" or "displaySmall"
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: theme.copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)
            // TRY THIS: Change the seedColor to "Colors.red" or
            //           "Colors.blue"
            ),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
