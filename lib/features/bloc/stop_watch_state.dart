part of 'stop_watch_cubit.dart';

class StopWatchState extends Equatable {
  final int time;
  final List<int> laps;
  final bool isRunning;

  const StopWatchState({this.time = 0, this.laps = const [], this.isRunning = false});

  @override
  List<Object> get props => [time, laps, isRunning];

  StopWatchState copyWith({
    int? time,
    List<int>? laps,
    bool? isRunning,
  }) {
    return StopWatchState(
      time: time ?? this.time,
      laps: laps ?? this.laps,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
