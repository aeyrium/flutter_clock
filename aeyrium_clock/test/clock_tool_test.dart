import 'package:aeyrium_clock/aeyrium_clock.dart';
import 'package:flutter_test/flutter_test.dart';

/// The focus of these tests are to validate that the ClockTool is
/// functioning correctly.  Because the entire app is centered around
/// displaying the information from this class, testing this logic
/// will greatly reduce the errors in the UI.
void main() {
  test('ClockTool.weekday works', () {
    String date = '2019-11-25T00:00:00-08:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);
    expect(tool.weekday, 'MON');

    date = '2019-11-26T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.weekday, 'TUE');

    date = '2019-11-27T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.weekday, 'WED');

    date = '2019-11-28T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.weekday, 'THU');

    date = '2019-11-29T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.weekday, 'FRI');

    date = '2019-11-30T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.weekday, 'SAT');

    date = '2019-12-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.weekday, 'SUN');
  });

  test('ClockTool.month', () {
    String date = '2019-01-01T00:00:00-08:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);
    expect(tool.month, 'JAN');

    date = '2019-02-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'FEB');

    date = '2019-03-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'MAR');

    date = '2019-04-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'APR');

    date = '2019-05-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'MAY');

    date = '2019-06-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'JUN');

    date = '2019-07-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'JUL');

    date = '2019-08-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'AUG');

    date = '2019-09-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'SEP');

    date = '2019-10-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'OCT');

    date = '2019-11-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'NOV');

    date = '2019-12-01T00:00:00-08:00';
    tool.now = DateTime.parse(date);
    expect(tool.month, 'DEC');
  });

  test('ClockTool.day', () {
    String date = '2019-01-01T00:00:00-08:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.day, 1);
  });

  test('ClockTool.hour (is24HourFormat == false)', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), false);

    expect(tool.hour, 12);

    date = '2019-10-01T01:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hour, 1);

    date = '2019-10-01T13:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hour, 1);

    date = '2019-10-01T23:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hour, 11);
  });

  test('ClockTool.hour (is24HourFormat == true)', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.hour, 0);

    date = '2019-10-01T01:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hour, 1);

    date = '2019-10-01T13:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hour, 13);

    date = '2019-10-01T23:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hour, 23);
  });

  test('ClockTool.minute', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.minute, 60);

    date = '2019-10-01T00:59:00';
    tool.now = DateTime.parse(date);

    expect(tool.minute, 59);

    date = '2019-10-01T00:01:00';
    tool.now = DateTime.parse(date);

    expect(tool.minute, 1);
  });

  test('ClockTool.dayAsString', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.dayAsString, "01");
  });

  test('ClockTool.hourAsString (is24HourFormat == false)', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), false);

    expect(tool.hourAsString, '12');

    date = '2019-10-01T01:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hourAsString, '01');

    date = '2019-10-01T13:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hourAsString, '01');

    date = '2019-10-01T23:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hourAsString, '11');
  });

  test('ClockTool.hourAsString (is24HourFormat == true)', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.hourAsString, '00');

    date = '2019-10-01T01:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hourAsString, '01');

    date = '2019-10-01T13:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hourAsString, '13');

    date = '2019-10-01T23:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.hourAsString, '23');
  });

  test('ClockTool.minuteAsString', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.minuteAsString, "00");

    date = '2019-10-01T00:59:00';
    tool.now = DateTime.parse(date);

    expect(tool.minuteAsString, "59");
  });

  test('ClockTool.secondAsString', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.secondAsString, "00");

    date = '2019-10-01T00:00:59';
    tool.now = DateTime.parse(date);

    expect(tool.secondAsString, "59");
  });

  test('ClockTool.suffix', () {
    String date = '2019-01-01T00:00:00';
    ClockTool tool = ClockTool(DateTime.parse(date), true);

    expect(tool.suffix, null);

    date = '2019-10-01T12:00:00';
    tool.now = DateTime.parse(date);
    tool.is24HourFormat = false;

    expect(tool.suffix, "AM");

    date = '2019-10-01T13:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.suffix, "PM");

    date = '2019-10-01T00:00:00';
    tool.now = DateTime.parse(date);

    expect(tool.suffix, "AM");
  });
}
