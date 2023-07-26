import 'package:flutter/material.dart';

abstract class StopwatchTheme {
  ThemeData get themeData;
}

class DeepPurpleStopwatchTheme extends StopwatchTheme {
  @override
  ThemeData get themeData => ThemeData(
        primaryColor: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          bodySmall: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          headlineLarge: TextStyle(
            color: Colors.grey,
            fontSize: 60,
            fontWeight: FontWeight.w200,
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w100,
          ),
        ),
      );
}
