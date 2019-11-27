import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

/// The primary purpose of this class is to load and cache assets
/// and to provide a timer that triggers an update every second.
class Assets {
  /// Images for the light theme
  Map<String, ui.Image> darkImages = {};

  /// Images for the dark theme
  Map<String, ui.Image> lightImages = {};

  bool isLoaded = false;

  /// This is the primary method that starts the loading of assets
  /// and starts the timer.
  Future<void> load() async {
    if (isLoaded == false) {
      List<Future<void>> futures = [];

      futures.add(_cache(darkImages, 'hour', 'Dark_Hour.png'));
      futures.add(_cache(darkImages, 'minute', 'Dark_Filled.png'));
      futures.add(_cache(darkImages, 'second', 'Dark_Second.png'));
      futures.add(_cache(darkImages, 'tnums', 'Dark_TimeFont.png'));
      futures.add(_cache(darkImages, 'font_large', 'Dark_Font_Large.png'));
      futures.add(_cache(darkImages, 'font_small', 'Dark_Font_Small.png'));

      futures.add(_cache(lightImages, 'hour', 'Light_Hour.png'));
      futures.add(_cache(lightImages, 'minute', 'Light_Filled.png'));
      futures.add(_cache(lightImages, 'second', 'Light_Second.png'));
      futures.add(_cache(lightImages, 'tnums', 'Light_TimeFont.png'));
      futures.add(_cache(lightImages, 'font_large', 'Light_Font_Large.png'));
      futures.add(_cache(lightImages, 'font_small', 'Light_Font_Small.png'));

      await Future.wait(futures);
      this.isLoaded = true;
    }
  }

  /// Loades the image with [filename] and adds to the [cache] using the
  /// specified [name] and returns it as a [Future]
  Future<void> _cache(
      Map<String, ui.Image> cache, String name, String filename) {
    return _loadImage('assets/images/$filename')
        .then((image) => cache[name] = image);
  }

  /// Utility method that loads Images bytes from the asset bundle.
  Future<ui.Image> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List img = Uint8List.view(data.buffer);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}
