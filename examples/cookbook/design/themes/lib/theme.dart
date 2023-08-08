import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appName = 'Custom Themes';

    // #docregion MaterialApp
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          brightness: Brightness.dark,
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
        ),
      ),
      home: const MyHomePage(
        title: appName,
      ),
    );
    // #enddocregion MaterialApp
  }
}

void theme(BuildContext context) {
  // #docregion Theme
  Theme(
    // Create a unique theme with `ThemeData`
    data: ThemeData(
      primarySwatch: Colors.pink,
    ),
    child: FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
  );
  // #enddocregion Theme

  // #docregion ThemeCopyWith
  Theme(
    // Find and extend the parent theme using `copyWith`.
    // To learn more, check out the next
    // section on `Theme.of`.
    data: Theme.of(context).copyWith(
        // TRY THIS: Change the seedColor to "Colors.red" or
        //           "Colors.blue"
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)),
    child: const FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),
  );
  // #enddocregion ThemeCopyWith
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
        // #docregion Container
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: theme.colorScheme.primary,
          child: Text(
            'Text with a background color',
            // TRY THIS: Change the Text value
            //           or change the theme.textTheme
            //           to "displayLarge" or "displaySmall"
            style: theme.textTheme.bodyMedium,
          ),
        ),
        // #enddocregion Container
      ),
      floatingActionButton: Theme(
        data: theme.copyWith(
            // TRY THIS: Change the seedColor to "Colors.red" or
            //           "Colors.blue"
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
