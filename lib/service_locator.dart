import 'package:get_it/get_it.dart';
import 'package:stopwatch/core/theme.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/stream_service.dart';

import 'generated/l10n.dart';

GetIt getIt = GetIt.instance;
final S tr = getIt<S>();
final StopwatchTheme theme = getIt<StopwatchTheme>();

void setup() {
  getIt.registerSingleton<StopwatchCubit>(
    StopwatchCubit(Stopwatch(), TimerServiceImpl()),
    instanceName: 'StopwatchCubit',
  );
  getIt.registerSingleton<S>(S.current);
  getIt.registerSingleton<StopwatchTheme>(DeepPurpleStopwatchTheme());
}
