import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stopwatch/core/theme.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/pages/stop_watch_page.dart';
import 'package:stopwatch/features/widgets/widgets.dart';
import 'package:stopwatch/generated/l10n.dart';
import 'package:stopwatch/service_locator.dart';

class MockStopWatchCubit extends MockCubit<StopWatchState> implements StopwatchCubit {}

void main() {
  final MockStopWatchCubit stopWatchBloc = MockStopWatchCubit();

  setUpAll(() {
    getIt.registerSingleton<StopwatchCubit>(stopWatchBloc, instanceName: 'StopwatchCubit');
    S.load(const Locale('en'));
    getIt.registerSingleton<S>(S.current);
    getIt.registerSingleton<StopwatchTheme>(DeepPurpleStopwatchTheme());
  });

  group('StopWatchPage', () {
    testWidgets('renders InitialWidget', (tester) async {
      when(() => stopWatchBloc.state).thenAnswer((invocation) => const StopWatchState(isRunning: false, time: 0, laps: []));

      const MaterialApp materialApp = MaterialApp(home: StopWatchPage());

      await tester.pumpWidget(materialApp);

      await tester.pump();

      expect(find.byType(InitialWidget), findsOneWidget);
    });

    testWidgets('renders StopWatchTimerWidget', (tester) async {
      when(() => stopWatchBloc.state).thenAnswer((invocation) => const StopWatchState(isRunning: true, time: 1000, laps: []));

      const MaterialApp materialApp = MaterialApp(home: StopWatchPage());

      await tester.pumpWidget(materialApp);

      await tester.pump();

      expect(find.byType(StopWatchTimerWidget), findsOneWidget);
    });
  });
}
