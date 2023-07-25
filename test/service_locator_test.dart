import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/service_locator.dart';

void main() {
  setUp(() async {
    setup();
  });
  test('registers an instance of StopwatchCubit', () {
    expect(getIt.isRegistered<StopwatchCubit>(instanceName: 'StopwatchCubit'), true);
  });
}
