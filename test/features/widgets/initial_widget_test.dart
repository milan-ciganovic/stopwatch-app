import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stopwatch/core/theme.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/widgets/initial_widget.dart';
import 'package:stopwatch/generated/l10n.dart';
import 'package:stopwatch/service_locator.dart';

import '../pages/stop_watch_page_test.dart';

void main() {
  final MockStopWatchCubit stopWatchBloc = MockStopWatchCubit();

  setUpAll(() {
    getIt.registerSingleton<StopwatchCubit>(stopWatchBloc, instanceName: 'StopwatchCubit');
    S.load(const Locale('en'));
    getIt.registerSingleton<S>(S.current);
    getIt.registerSingleton<StopwatchTheme>(DeepPurpleStopwatchTheme());
  });

  testWidgets('renders InitialWidget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: InitialWidget(
      displayTime: '02:12',
    ))));

    await tester.pump();

    expect(find.text(tr.stopwatch), findsOneWidget);
    expect(find.text('02:12'), findsOneWidget);
    expect(find.text(tr.ready), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('calls startTimer() when start button is pressed', (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: InitialWidget(
      displayTime: '',
    ))));

    await tester.pump();

    await tester.tap(find.byType(TextButton));

    await tester.pumpAndSettle();

    verify(() => stopWatchBloc.startTimer()).called(1);
  });
}
