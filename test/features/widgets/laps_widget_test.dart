import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/core/theme.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/widgets/laps_widget.dart';
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

  testWidgets('renders LapsWidget', (tester) async {
    const List<int> laps = [0];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              LapsWidget(
                state: const StopWatchState(laps: laps, time: 16000, isRunning: true),
                scrollController: ScrollController(),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    for (int i = 0; i < laps.length; i++) {
      expect(find.text('Lap ${i + 1}'), findsOneWidget);
    }
    expect(find.text('Lap ${laps.length + 1}'), findsOneWidget);
    expect(find.text('00:16.00'), findsOneWidget);
  });
}
