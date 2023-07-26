import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/generated/l10n.dart';
import 'package:stopwatch/service_locator.dart';


void main() {
  setUp(() async {
    S.load(const Locale('en'));

    setup();
  });
  test('registers an instance of StopwatchCubit', () {
    expect(getIt.isRegistered<StopwatchCubit>(instanceName: 'StopwatchCubit'), true);
    expect(getIt.isRegistered<S>(instance: tr), true);
  });
}
