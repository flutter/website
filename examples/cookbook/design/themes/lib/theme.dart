import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void theme(BuildContext context) {
  // #docregion Theme
  ThemeData(
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

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.pink,
      splashColor: Colors.yellow,
    ),
  ),

  // #docregion ThemeCopyWith
  Theme(
    // Find and extend the parent theme using `copyWith`. See the next
    // section for more info on `Theme.of`.
    data: Theme.of(context).copyWith(splashColor: Colors.yellow),
    child: const FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),
  );
  // #enddocregion ThemeCopyWith
}
