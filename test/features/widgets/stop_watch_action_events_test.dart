import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/widgets/widgets.dart';
import 'package:stopwatch/service_locator.dart';

import '../pages/stop_watch_page_test.dart';

void main() {
  final StopWatchCubit stopWatchBloc = MockStopWatchCubit();

  setUpAll(() {
    getIt.registerSingleton<StopWatchCubit>(stopWatchBloc);
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

    expect(find.byIcon(Icons.refresh), findsOneWidget);
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

    await tester.tap(find.byKey(const Key('playPause')));

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

    await tester.tap(find.byKey(const Key('playPause')));

    await tester.pumpAndSettle();

    verify(() => stopWatchBloc.startTimer());
  });

  testWidgets('when player is not running and "ResetTimer" button is tapped, should call "resetTimer"', (tester) async {
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

    await tester.tap(find.byKey(const Key('resetTimer')));

    await tester.pumpAndSettle();

    verify(() => stopWatchBloc.resetTimer());
  });

  testWidgets('when player is running and "AddLap" button is tapped, should call "addLap"', (tester) async {
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

    await tester.tap(find.byKey(const Key('addLap')));

    await tester.pumpAndSettle();

    verify(() => stopWatchBloc.addLap());
  });
}
