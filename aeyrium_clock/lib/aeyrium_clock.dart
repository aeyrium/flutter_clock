library aeyrium_clock;

import 'dart:async';

import 'package:aeyrium_clock/src/assets.dart';
import 'package:aeyrium_clock/src/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'src/digital_painter.dart';

export 'src/clock_tool.dart';
export 'src/digital_text.dart';
export 'src/clock_tool.dart';
export 'src/digital_dial.dart';
export 'src/digital_painter.dart';
export 'src/digital_text.dart';
export 'src/assets.dart';

/// [AeyriumClock] is the main Widget for the clock application.  It has very little
/// interactivity save for the storage of a [ClockModel] and a [ClockNotifier].
/// It also provides a fallback Progress Indicator while the assets are being loaded
/// to render the clock's UI.
class AeyriumClock extends StatefulWidget {
  AeyriumClock(this.model);

  final ClockModel model;

  _AeyriumClockState createState() => _AeyriumClockState();
}

class _AeyriumClockState extends State<AeyriumClock> {
  DateTime _now = DateTime.now();
  String _temp;
  WeatherCondition _condition;
  Timer _timer;
  Assets _assets = Assets();
  Future<void> _loader;

  @override
  void initState() {
    super.initState();
    _loader = _assets.load();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AeyriumClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _condition = widget.model.weatherCondition;
      _temp = widget.model.temperatureString;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loader,
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return _clockBuilder(context);
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _clockBuilder(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 50.0),
      decoration: _convert2Deco(_condition, themeData.brightness),
      child: FittedBox(
        fit: BoxFit.contain,
        child: CustomPaint(
          key: Key('digital_painter'),
          painter: DigitalPainter(
            _now,
            widget.model.is24HourFormat,
            themeData.brightness == Brightness.light
                ? _assets.darkImages
                : _assets.lightImages,
          ),
          child: SizedBox(
            width: 490,
            height: 490,
          ),
        ),
      ),
    );
  }

  BoxDecoration _convert2Deco(
      WeatherCondition condition, Brightness brightness) {
    if (brightness == Brightness.light) {
      switch (condition) {
        case WeatherCondition.cloudy:
          return COCHITI_LAKE;
        case WeatherCondition.foggy:
          return PURE_WATER;
        case WeatherCondition.rainy:
          return AQUA_SPLASH;
        case WeatherCondition.snowy:
          return COCHITI_LAKE;
        case WeatherCondition.sunny:
          return JUICY_PEACH;
        case WeatherCondition.thunderstorm:
          return VICIOUS_STANCE;
        case WeatherCondition.windy:
          return COCHITI_LAKE;
      }
    }
    return null;
  }
}
