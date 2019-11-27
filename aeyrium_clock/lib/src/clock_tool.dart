enum Weekday { MON, TUE, WED, THU, FRI, SAT, SUN }

enum Month { JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC }

/// This is a utility for a clock application that centralizes all the various
/// transformations and formatting fuctions required to translate a [DateTime]
/// value as needed for display.
class ClockTool {
  /// Creates a tool that operates on [now] and takes into account the [is24HourFormat]
  ClockTool(DateTime now, bool is24HourFormat) {
    this.now = now;
    this.is24HourFormat = is24HourFormat;
  }

  /// The [DateTime] being formatted by this tool.
  DateTime now;

  /// The format assumed by the tool. 24hr format if [true].
  bool is24HourFormat;

  /// Returns the textual abbrev for the weekday as it should appear
  /// on screen by the UI.  Format is 3 letters and all uppercase by default.
  String get weekday {
    Weekday weekday = Weekday.values[now.weekday - 1];
    return enumToString(weekday);
  }

  /// Returns the textual abbrev for the month as it should appear
  /// on screen by the UI.  Format is 3 letters and all uppercase by default.
  String get month {
    Month month = Month.values[now.month - 1];
    return enumToString(month);
  }

  /// Returns the day of the month as an integers between 1 and 31
  int get day {
    return now.day;
  }

  /// Returns the hour of the day as a value between `0` and `23` if [is24HourFormat]
  /// is `true` or as a value between `1` and `12` if `false`.
  int get hour {
    int h = now.hour;
    if (is24HourFormat == false) {
      switch (h) {
        case 0:
          return 12;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
          return h;
        default:
          return h - 12;
      }
    }
    return h;
  }

  /// Returns the minute as a value between `1` and `60`.
  int get minute {
    return (now.minute == 0) ? 60 : now.minute;
  }

  /// Returns the minute as a value between `1` and `60`.
  int get second {
    return (now.second == 0) ? 60 : now.second;
  }

  /// Returns the day of month as a 2 character padded string (e.g. `4` would return `"04"`)
  String get dayAsString {
    return this.now.day.toString().padLeft(2, '0');
  }

  /// Returns the hour as a 2 character padded string (e.g. `4` would return `"04"`)
  String get hourAsString {
    return this.hour.toString().padLeft(2, '0');
  }

  /// Returns the minute as a 2 character padded string (e.g. `4` would return `"04"`)
  String get minuteAsString {
    return this.now.minute.toString().padLeft(2, '0');
  }

  /// Returns the second as a padded string (e.g. `4` would return `"04"`)
  String get secondAsString {
    return this.now.second.toString().padLeft(2, '0');
  }

  /// Returns the correct suffix `"AM"` or `"PM"` if [is24HourFormat] is `false` or
  /// else if [is24HourFormat] is `true` then it returns `null`.
  String get suffix {
    if (is24HourFormat)
      return null;
    else if (this.now.hour > 12)
      return 'PM';
    else
      return 'AM';
  }
}

/// Removes the enum type and returns the value as a String.
String enumToString(Object e) => e.toString().split('.').last;
