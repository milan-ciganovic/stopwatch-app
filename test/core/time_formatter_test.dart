import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/core/time_formatter.dart';

void main() {
  group('TimeFormatter', () {
    test('Should format time with hours, minutes, seconds, and milliseconds', () {
      final formattedTime = TimeFormatter.formatTime(milliseconds: 3661000);
      expect(formattedTime, equals('01:01:01.00'));
    });

    test('Should format time with hours and minutes only', () {
      final formattedTime = TimeFormatter.formatTime(milliseconds: 7200000, showSeconds: false, showMilliseconds: false);
      expect(formattedTime, equals('02:00'));
    });

    test('Should format time with minutes and seconds only', () {
      final formattedTime = TimeFormatter.formatTime(milliseconds: 150000, showHours: false, showMilliseconds: false);
      expect(formattedTime, equals('02:30'));
    });

    test('Should format time with seconds and milliseconds only', () {
      final formattedTime = TimeFormatter.formatTime(milliseconds: 59000, showHours: false, showMinutes: false);
      expect(formattedTime, equals('59.00'));
    });

    test('Should format time with hours only', () {
      final formattedTime =
          TimeFormatter.formatTime(milliseconds: 10800000, showMinutes: false, showSeconds: false, showMilliseconds: false);
      expect(formattedTime, equals('03'));
    });

    test('Should format time with minutes only', () {
      final formattedTime = TimeFormatter.formatTime(milliseconds: 420000, showHours: false, showSeconds: false, showMilliseconds: false);
      expect(formattedTime, equals('07'));
    });

    test('Should format time with seconds only', () {
      final formattedTime = TimeFormatter.formatTime(milliseconds: 59000, showHours: false, showMinutes: false, showMilliseconds: false);
      expect(formattedTime, equals('59'));
    });

    test('Should format time with milliseconds only', () {
      final formattedTime = TimeFormatter.formatTime(milliseconds: 450, showHours: false, showMinutes: false, showSeconds: false);
      expect(formattedTime, equals('45'));
    });
  });
}
