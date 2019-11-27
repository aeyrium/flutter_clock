import 'dart:ui' as ui;
import 'package:angles/angles.dart';
import 'package:flutter/material.dart';

/// Renders a digital dial on the specified canvas.  Requires a canvas of 490 x 490 px.
class DigitalDial {
  DigitalDial(this._canvas, this._size, this._images);

  Canvas _canvas;
  Size _size;
  Map<String, ui.Image> _images;

  /// Paints a dial showing the specified [hour], [minute], and [second].
  void paint(int hour, int minute, int second) {
    print(hour);
    hour = (hour > 12) ? hour - 12 : hour;
    hour = (hour == 0) ? 12 : hour;
    print(hour);
    // NOTE: The images that are used to render the clock dials have the demension
    // of 240px x 245px.  Each dial "slice" is rendered relative to the same
    // dimensions to provide a common frame of reference and therefore make it
    // easier to draw them to the canvas.

    // Let's use the "hour" slide image (since the are all the same) to compute
    // the starting reference position.  The original hour slide (and other slices)
    // are rendered in the 12:00 position.
    var image = _images["hour"];

    // Compute the top-left origin for the image so that it is perfectly centered
    // horizontally and position just above the middle of the screen.
    _canvas.translate((_size.width - image.width) / 2,
        (_size.height - (image.height * 2)) / 2);

    // Compute the relative translation to the middle center point of the images
    // to be used as the point around which the images will be rotated to create
    // each of the dials.
    double cx = image.width / 2;
    double cy = image.height.toDouble();

    // Create a Paint that has opacity 20%
    final alpha20Paint = Paint();
    alpha20Paint.color = Color.fromRGBO(0, 0, 0, 0.05);

    // Create a Paint that has opacity 40%
    final alpha40Paint = Paint();
    alpha40Paint.color = Color.fromRGBO(0, 0, 0, 0.2);

    // Create a Paint with 100% opacity
    final opaquePaint = Paint();
    opaquePaint.color = Color.fromRGBO(0, 0, 0, 0.8);

    // Draw the "hour" ring by rotating in 30 degrees increments
    _canvas.drawImage(image, Offset.zero, opaquePaint);
    final a30 = Angle.fromDegrees(30.0).radians;
    for (int slice = 2; slice <= 12; slice++) {
      _rotate(_canvas, a30, cx, cy);
      if (slice <= hour)
        _canvas.drawImage(image, Offset.zero, opaquePaint);
      else
        _canvas.drawImage(image, Offset.zero, alpha20Paint);
    }

    // Rotate one more time to return the canvas to the starting position
    _rotate(_canvas, a30, cx, cy);

    // Draw the "minute" ring by rotating in 6 degree increments
    image = _images["minute"];
    _canvas.drawImage(
        image, Offset.zero, (minute == 1) ? opaquePaint : alpha40Paint);
    final a6 = Angle.fromDegrees(6.0).radians;
    for (int mslice = 2; mslice <= 60; mslice++) {
      _rotate(_canvas, a6, cx, cy);
      if (mslice == minute) {
        // Draw "current minute"
        _canvas.drawImage(image, Offset.zero, opaquePaint);
      } else if (mslice < minute) {
        // Draw "past minutes"
        _canvas.drawImage(image, Offset.zero, alpha40Paint);
      } else {
        // Draw "future minutes"
        _canvas.drawImage(image, Offset.zero, alpha20Paint);
      }
    }

    // Rotate one more time to return the canvas to the starting position
    _rotate(_canvas, a6, cx, cy);

    // Draw the "seconds" ring by ratating in 6 degree increments
    image = _images["second"];
    _canvas.drawImage(image, Offset.zero, new Paint());
    for (int mslice = 2; mslice <= 60; mslice++) {
      _rotate(_canvas, a6, cx, cy);
      if (mslice <= second) {
        // Draw current / past seconds
        _canvas.drawImage(image, Offset.zero, opaquePaint);
      } else {
        // Draw future seconds
        _canvas.drawImage(image, Offset.zero, alpha20Paint);
      }
    }
  }

  /// Rotate canvas around a custom focal point instead of the default top-left
  /// that is normal for an image.
  void _rotate(Canvas canvas, double rad, double tx, double ty) {
    canvas.translate(tx, ty);
    canvas.rotate(rad);
    canvas.translate(-tx, -ty);
  }
}
