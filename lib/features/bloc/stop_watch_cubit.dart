import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'stop_watch_state.dart';

class StopWatchCubit extends Cubit<StopWatchState> {
  final StopWatchTimer stopWatchTimer;

  StopWatchCubit({required this.stopWatchTimer}) : super(const StopWatchState());

  void startTimer() async {
    stopWatchTimer.onStartTimer();

    stopWatchTimer.rawTime.listen((time) {
      emit(state.copyWith(time: time, isRunning: true));
    });
  }

  void stopTimer() {
    stopWatchTimer.onStopTimer();
    emit(state.copyWith(isRunning: false));
  }

  void resetTimer() {
    stopWatchTimer.onResetTimer();
  }

  void addLap() async {
    stopWatchTimer.onAddLap();

    final sw = await stopWatchTimer.records.first;
    emit(state.copyWith(laps: sw.map((e) => e.rawValue!).toList()));
  }
}
