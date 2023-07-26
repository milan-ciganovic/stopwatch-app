import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stopwatch/features/stream_service.dart';

class MockTimerService extends Mock implements TimerService {}

void main() {
  late final MockTimerService mockTimerService;

  setUp(() => mockTimerService = MockTimerService());

  test('should return results periodically from stream', () {
    final tStream = Stream.fromIterable([1, 2, 3]);
    when(() => mockTimerService.periodic(const Duration(milliseconds: 200))).thenAnswer((_) => tStream);

    final result = mockTimerService.periodic(const Duration(milliseconds: 200));

    expect(result, tStream);
  });
}
