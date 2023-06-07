import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';

class MockStopWatchCubit extends MockCubit<StopWatchState> implements StopWatchCubit {}

void main() {
  group('StopWatchCubit', () {
    test('initial state is TimerInitial(60)', () {
      final StopWatchTimer mockStopWatchTimer = StopWatchTimer();

      expect(
        StopWatchCubit(stopWatchTimer: mockStopWatchTimer).state,
        const StopWatchState(),
      );
    });

    test('emitsStatesInOrder', () {
      final bloc = MockStopWatchCubit();

      whenListen(
          bloc,
          Stream<StopWatchState>.fromIterable([
            const StopWatchState(isRunning: false),
            const StopWatchState(isRunning: true),
          ]));

      expectLater(
          bloc.stream,
          emitsInOrder([
            const StopWatchState(isRunning: false),
            const StopWatchState(isRunning: true),
          ]));
    });

    blocTest<StopWatchCubit, StopWatchState>(
      'startTimer',
      build: () => StopWatchCubit(stopWatchTimer: StopWatchTimer()),
      act: (bloc) {
        bloc.startTimer();
      },
      expect: () => [
        const StopWatchState(time: 0, laps: [], isRunning: false),
        const StopWatchState(time: 0, laps: [], isRunning: true),
      ],
    );

    blocTest<StopWatchCubit, StopWatchState>(
      'addLap',
      setUp: () {},
      build: () => StopWatchCubit(stopWatchTimer: StopWatchTimer()),
      act: (bloc) async {
        bloc.startTimer();
        bloc.addLap();
        bloc.stopTimer();
        return bloc;
      },
      expect: () => [
        const StopWatchState(time: 0, laps: [], isRunning: false),
        const StopWatchState(time: 0, laps: [], isRunning: true),
        const StopWatchState(time: 0, laps: [0], isRunning: true),
      ],
    );

    blocTest<StopWatchCubit, StopWatchState>('resetTimer',
        build: () => StopWatchCubit(stopWatchTimer: StopWatchTimer()),
        act: (bloc) {
          bloc.startTimer();
          bloc.resetTimer();
        },
        expect: () => [const StopWatchState(time: 0, laps: [], isRunning: true)]);
  });
}
