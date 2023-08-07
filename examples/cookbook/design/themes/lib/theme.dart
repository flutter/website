import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    data: Theme.of(context)
        .copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)
            // TRY THIS: Change the seedColor to "Colors.red" or
            //           "Colors.blue"
            ),
    child: const FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),
  );
  // #enddocregion ThemeCopyWith
}
