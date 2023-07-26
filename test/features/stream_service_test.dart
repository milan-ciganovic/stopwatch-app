import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/features/stream_service.dart';

void main() {
  late final TimerServiceImpl timerServiceImpl;

  setUp(() => timerServiceImpl = TimerServiceImpl());

  test('should return results periodically from stream', () {
    final Stream<int> result = timerServiceImpl.periodic(const Duration(milliseconds: 3));

    expect(result, emitsInOrder([0, 1, 2]));
  });
}
