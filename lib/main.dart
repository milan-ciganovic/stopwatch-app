import 'package:flutter/material.dart';
import 'package:stopwatch/features/pages/stop_watch_page.dart';
import 'package:stopwatch/generated/l10n.dart';

import 'service_locator.dart';

void main() {
  S.load(const Locale('en'));
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: tr.stopwatch,
      theme: theme.themeData,
      // theme: ThemeData(
      //   primarySwatch: Colors.deepPurple,
      //   brightness: Brightness.dark,
      // ),
      home: const StopWatchPage(),
    );
  }
}
