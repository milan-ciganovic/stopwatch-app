import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/stream_service.dart';
import 'package:bloc_test/bloc_test.dart';

class MockStopwatch extends Mock implements Stopwatch {}

class MockStreamPeriodicTimerService extends Mock implements TimerServiceImpl {}

void main() {
  late final MockStopwatch mockStopwatch;
  late final MockStreamPeriodicTimerService mockStreamPeriodicTimerService;

  setUpAll(() {
    mockStopwatch = MockStopwatch();
    mockStreamPeriodicTimerService = MockStreamPeriodicTimerService();

    when(() => mockStreamPeriodicTimerService.periodic(const Duration(milliseconds: 200))).thenAnswer((_) => const Stream.empty());
    when(() => mockStopwatch.isRunning).thenReturn(true);
    when(() => mockStopwatch.elapsedMilliseconds).thenReturn(0);
  });

  group('StopwatchCubit', () {
    blocTest<StopwatchCubit, StopWatchState>('emits the correct state when startTimer is called',
        build: () => StopwatchCubit(mockStopwatch, mockStreamPeriodicTimerService),
        act: (cubit) {
          cubit.startTimer();
        },
        expect: () => [const StopWatchState(isRunning: true, time: 0)],
        verify: (bloc) {
          verify(() => mockStopwatch.start()).called(1);
        });

    blocTest<StopwatchCubit, StopWatchState>(
      'emits the correct state when stopTimer is called',
      build: () => StopwatchCubit(mockStopwatch, mockStreamPeriodicTimerService),
      act: (cubit) => cubit.stopTimer(),
      expect: () => [const StopWatchState(isRunning: false)],
    );

    blocTest<StopwatchCubit, StopWatchState>(
      'emits the correct state when resetTimer is called',
      build: () => StopwatchCubit(mockStopwatch, mockStreamPeriodicTimerService),
      act: (cubit) => cubit.resetTimer(),
      expect: () => [const StopWatchState(time: 0, laps: [])],
    );
    blocTest<StopwatchCubit, StopWatchState>(
      'emits the correct state when addLap is called',
      build: () => StopwatchCubit(mockStopwatch, mockStreamPeriodicTimerService),
      act: (cubit) async {
        cubit.startTimer();
        cubit.addLap();
      },
      expect: () => [
        const StopWatchState(isRunning: true, laps: []),
        const StopWatchState(isRunning: true, laps: [0]),
      ],
    );
  });
}
