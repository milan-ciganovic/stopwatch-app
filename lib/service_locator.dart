import 'package:get_it/get_it.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<StopWatchCubit>(StopWatchCubit(stopWatchTimer: StopWatchTimer()));
}
