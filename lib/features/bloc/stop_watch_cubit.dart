import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/features/stream_service.dart';

part 'stop_watch_state.dart';

class StopwatchCubit extends Cubit<StopWatchState> {
  final Stopwatch _stopwatch;
  final TimerServiceImpl streamPeriodicTimerService;
  StreamSubscription<dynamic>? _timer;

  StopwatchCubit(this._stopwatch, this.streamPeriodicTimerService) : super(const StopWatchState());

  void startTimer() {
    _stopwatch.start();
    _timer = streamPeriodicTimerService.periodic(const Duration(milliseconds: 200)).listen((event) {
      if (_stopwatch.isRunning) {
        emit(state.copyWith(time: _stopwatch.elapsedMilliseconds, isRunning: true));
      }
    });
  }

  void stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      emit(state.copyWith(isRunning: false));
    }
  }

  void resetTimer() {
    _stopwatch.reset();
    emit(state.copyWith(time: 0, laps: []));
  }

  void addLap() {
    if (_stopwatch.isRunning) {
      final int lap = _stopwatch.elapsedMilliseconds;
      emit(state.copyWith(laps: [...state.laps, lap]));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
