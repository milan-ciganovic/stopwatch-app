import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/widgets/initial_widget.dart';
import 'package:stopwatch/service_locator.dart';

import '../pages/stop_watch_page_test.dart';

void main() {
  final MockStopWatchCubit stopWatchBloc = MockStopWatchCubit();

  setUpAll(() {
    getIt.registerSingleton<StopWatchCubit>(stopWatchBloc);
  });

  testWidgets('renders InitialWidget', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: InitialWidget())));

    await tester.pump();

    expect(find.text('Stopwatch'), findsOneWidget);
    expect(find.text('00:00'), findsOneWidget);
    expect(find.text('Ready?'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
}
