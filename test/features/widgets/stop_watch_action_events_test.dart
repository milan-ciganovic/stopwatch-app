import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stopwatch/core/constants.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/widgets/widgets.dart';
import 'package:stopwatch/generated/l10n.dart';
import 'package:stopwatch/service_locator.dart';

import '../pages/stop_watch_page_test.dart';

void main() {
  final MockStopWatchCubit stopWatchBloc = MockStopWatchCubit();

  setUpAll(() {
    getIt.registerSingleton<StopwatchCubit>(stopWatchBloc, instanceName: 'StopwatchCubit');
    S.load(const Locale('en'));
    getIt.registerSingleton<S>(S.current);
  });

  testWidgets('finds "AddLap" and "Pause" button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StopWatchActionEvents(
            scrollController: ScrollController(),
            isRunning: true,
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byIcon(Icons.flag), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsOneWidget);

    await tester.tap(find.byKey(const Key('playPause')));

    await tester.pumpAndSettle();

    verify(() => stopWatchBloc.stopTimer());
  });

  testWidgets('renders StopWatchActionEvents', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StopWatchActionEvents(
            scrollController: ScrollController(),
            isRunning: false,
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });

  testWidgets('when "Pause" button is tapped, call "stopTimer"', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StopWatchActionEvents(
            scrollController: ScrollController(),
            isRunning: true,
          ),
        ),
      ),
    );

    await tester.pump();

    await tester.tap(find.byKey(const Key(playPauseKey)));

    await tester.pumpAndSettle();

    verify(() => stopWatchBloc.stopTimer());
  });

  testWidgets('when "Play" button is tapped, call "startTimer"', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StopWatchActionEvents(
            scrollController: ScrollController(),
            isRunning: false,
          ),
        ),
      ),
    );

    await tester.pump();

    await tester.tap(find.byKey(const Key(playPauseKey)));

    await tester.pumpAndSettle();

    verify(() => stopWatchBloc.startTimer());
  });
}
