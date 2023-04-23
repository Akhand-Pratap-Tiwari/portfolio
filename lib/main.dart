import 'package:flutter/material.dart';

import 'constraints.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleWhite = const TextStyle(color: Colors.white);
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.white),
        textTheme: ThemeData.dark().textTheme.copyWith(
              displayLarge: textStyleWhite,
              displayMedium: textStyleWhite,
              displaySmall: textStyleWhite,
              bodyLarge: textStyleWhite,
              bodyMedium: textStyleWhite,
              bodySmall: textStyleWhite,
              headlineLarge: textStyleWhite,
              headlineMedium: textStyleWhite,
              headlineSmall: textStyleWhite,
            ),
      ),
      home: const Constraints(),

      // TODO: Code Organizatino and Breakup
      // TODO: Setup Mobile Layout
      // TODO: Remove Print Statements
    );
  }
}
