import 'package:flutter/material.dart';

abstract class StopwatchTheme {
  ThemeData get themeData;
}

class DeepPurpleStopwatchTheme extends StopwatchTheme {
  @override
  // TODO: implement themeData
  ThemeData get themeData => ThemeData(textTheme: const TextTheme());

// const TextStyle defaultTextStyle = TextStyle(
//   color: Colors.grey,
//   fontSize: 16,
// );
//
// const TextStyle headingTextStyle = TextStyle(
//   color: Colors.grey,
//   fontSize: 60,
//   fontWeight: FontWeight.w200,
// );
//
// const TextStyle subheadingTextStyle = TextStyle(
//   color: Colors.grey,
//   fontSize: 12,
//   fontWeight: FontWeight.w100,
// );
}
