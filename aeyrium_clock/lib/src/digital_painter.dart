import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'clock_tool.dart';
import 'digital_text.dart';
import 'digital_dial.dart';

/// This is the painter for the [DigitalClock] that handles all
/// the custom canvas painting require to render the clock dial
/// and digital text information.
class DigitalPainter extends CustomPainter {
  /// Created to paint a clock in a state that reflects the time [now]
  /// with [is24HourFormat] set and the necessary [images] for the
  /// curent theme.
  DigitalPainter(
      DateTime now, bool is24HourFormat, Map<String, ui.Image> images) {
    this._now = now;
    this._is24HourFormat = is24HourFormat;
    this._images = images;
  }

  DateTime _now;
  bool _is24HourFormat;
  Map<String, ui.Image> _images;

  @override
  void paint(Canvas canvas, Size size) {
    ClockTool tool = ClockTool(_now, _is24HourFormat);
    DigitalDial ringDial = DigitalDial(canvas, size, _images);
    final smlText = DigitalText(canvas, _images['font_small']);
    final lrgText = DigitalText(canvas, _images['font_large']);

    String weekday = tool.weekday;
    String month = tool.month;
    String day = tool.dayAsString;
    String hour = tool.hourAsString;
    String min = tool.minuteAsString;
    String suffix = tool.suffix;

    smlText.paint(weekday, Offset(size.width / 2, 100));
    smlText.paint('$month-$day', Offset(size.width / 2, 150));
    lrgText.paint('$hour:$min', Offset(size.width / 2, 210));
    smlText.paint(suffix, Offset(size.width / 2 + 70, 280));
    ringDial.paint(tool.hour, tool.minute, tool.second);
  }

  @override
  bool shouldRepaint(DigitalPainter oldDelegate) => true;
}
