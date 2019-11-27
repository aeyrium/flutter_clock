import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Functions like a font, used to render stylized letters to the
/// [Canvas] that mimic an old-school digital display
class DigitalText {
  /// A map of all the supported characters and the order in which they
  /// appear in the font image.
  static const LETTER_INDEX = {
    'A': 0,
    'B': 1,
    'C': 2,
    'D': 3,
    'E': 4,
    'F': 5,
    'G': 6,
    'H': 7,
    'I': 8,
    'J': 9,
    'L': 10,
    'M': 11,
    'N': 12,
    'O': 13,
    'P': 14,
    'R': 15,
    'S': 16,
    'T': 17,
    'U': 18,
    'V': 19,
    'W': 20,
    'Y': 21,
    '0': 22,
    '1': 23,
    '2': 24,
    '3': 25,
    '4': 26,
    '5': 27,
    '6': 28,
    '7': 29,
    '8': 30,
    '9': 31,
    '-': 32,
    ':': 33,
  };

  /// Renders the text to the [canvas] using the image [font].
  /// NOTE: The font image is a strip with characters for each
  /// of the values specified in the [LETTER_INDEX] map.
  DigitalText(Canvas canvas, ui.Image font) {
    this.font = font;
    this.canvas = canvas;
  }

  Canvas canvas;
  ui.Image font;

  /// Paints the stylize digital text at the point (top-right)
  /// that is specified.
  void paint(String text, Offset point) {
    if (text != null) {
      double lw = font.width / LETTER_INDEX.length;
      double lh = font.height.toDouble();

      double x = point.dx - ((lw * text.length) / 2);

      for (int ndx = 0; ndx < text.length; ndx++) {
        String letter = text[ndx];
        Rect srcRect = Rect.fromLTWH(LETTER_INDEX[letter] * lw, 0, lw, lh);
        Rect toRect = Rect.fromLTWH(x + (ndx * lw), point.dy, lw, lh);
        canvas.drawImageRect(font, srcRect, toRect, Paint());
      }
    }
  }
}
