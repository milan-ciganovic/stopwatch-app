class TimeFormatter {
  static String formatTime({
    int milliseconds = 0,
    bool showHours = true,
    bool showMinutes = true,
    bool showSeconds = true,
    bool showMilliseconds = true,
    String hoursSeparator = ':',
    String minutesSeparator = ':',
    String secondsSeparator = '.',
  }) {
    final hoursStr = _getDisplayHours(milliseconds);
    final minutesStr = _getDisplayMinutes(milliseconds, showHours: showHours);
    final secondsStr = _getDisplaySeconds(milliseconds, showMinutes: showMinutes);
    final millisecondsStr = _getDisplayMilliseconds(milliseconds);

    var result = '';
    if (showHours) {
      result += hoursStr;
    }
    if (showMinutes) {
      if (showHours) {
        result += hoursSeparator;
      }
      result += minutesStr;
    }
    if (showSeconds) {
      if (showMinutes) {
        result += minutesSeparator;
      }
      result += secondsStr;
    }
    if (showMilliseconds) {
      if (showSeconds) {
        result += secondsSeparator;
      }
      result += millisecondsStr;
    }
    return result;
  }

  /// Get display hours time.
  static String _getDisplayHours(int milliseconds) {
    return (_getTotalHours(milliseconds)).toString().padLeft(2, '0');
  }

  /// Get display minutes time.
  static String _getDisplayMinutes(int milliseconds, {bool showHours = false}) {
    if (showHours) {
      return _getMinutesInHour(milliseconds).toString().padLeft(2, '0');
    } else {
      return (_getTotalMinutes(milliseconds)).toString().padLeft(2, '0');
    }
  }

  /// Get display seconds time.
  static String _getDisplaySeconds(int milliseconds, {bool showMinutes = false}) {
    final seconds = (_getTotalSeconds(milliseconds) % 60);
    return seconds.toString().padLeft(2, '0');
  }

  /// Get display milliseconds time.
  static String _getDisplayMilliseconds(int mSec) {
    final ms = (mSec % 1000 / 10).floor();
    return ms.toString().padLeft(2, '0');
  }

  /// Get total hours.
  static int _getTotalHours(int milliseconds) => (milliseconds / (3600 * 1000)).floor();

  /// Get total minutes.
  static int _getTotalMinutes(int milliseconds) => (milliseconds / (60 * 1000)).floor();

  /// Get minutes in an hour.
  static int _getMinutesInHour(int milliseconds) => (_getTotalMinutes(milliseconds) % 60);

  /// Get total seconds.
  static int _getTotalSeconds(int milliseconds) => (milliseconds / 1000).floor();
}
