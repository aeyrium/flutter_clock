library aeyrium_clock;

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'src/digital_painter.dart';
import 'src/clock_notifier.dart';

export 'src/clock_notifier.dart';

export 'src/clock_tool.dart';
export 'src/digital_text.dart';
export 'src/clock_tool.dart';
export 'src/digital_dial.dart';
export 'src/digital_painter.dart';
export 'src/digital_text.dart';

/// [AeyriumClock] is the main Widget for the clock application.  It has very little
/// interactivity save for the storage of a [ClockModel] and a [ClockNotifier].
/// It also provides a fallback Progress Indicator while the assets are being loaded
/// to render the clock's UI.
class AeyriumClock extends StatelessWidget {
  AeyriumClock(this.model, this.notifier);

  final ClockModel model;
  final ClockNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier,
      child: const Center(),
      builder: (_, child) {
        if (notifier.isReady) {
          return _clockBuilder(context);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _clockBuilder(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return FittedBox(
      fit: BoxFit.contain,
      child: CustomPaint(
        key: Key('digital_painter'),
        painter: DigitalPainter(
          notifier.now,
          model.is24HourFormat,
          themeData.brightness == Brightness.light
              ? notifier.darkImages
              : notifier.lightImages,
        ),
        child: SizedBox(
          width: 490,
          height: 490,
        ),
      ),
    );
  }
}
