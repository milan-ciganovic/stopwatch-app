import 'package:get_it/get_it.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/stream_service.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<StopwatchCubit>(
    StopwatchCubit(Stopwatch(), StreamPeriodicTimerService()),
    instanceName: 'StopwatchCubit',
  );
}
