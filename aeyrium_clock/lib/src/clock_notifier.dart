import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const IMAGE_PATH = "assets/images/";

/// The primary purpose of this class is to load and cache assets
/// and to provide a timer that triggers an update every second.
class ClockNotifier with ChangeNotifier {
  /// Images for the light theme
  Map<String, ui.Image> darkImages = {};

  /// Images for the dark theme
  Map<String, ui.Image> lightImages = {};

  /// The internal timer used to generate events every second
  Timer _timer;

  /// The current time as of the last timer event was triggered
  DateTime now = DateTime.now();

  /// Indicates when the assets are loaded and ready.
  bool isReady = false;

  /// This is the primary method that starts the loading of assets
  /// and starts the timer.
  Future<void> loadAssets() async {
    darkImages['hour'] = await _loadImage('${IMAGE_PATH}Dark_Hour.png');
    darkImages['minute'] = await _loadImage('${IMAGE_PATH}Dark_Filled.png');
    darkImages['second'] = await _loadImage('${IMAGE_PATH}Dark_Second.png');
    darkImages['tnums'] = await _loadImage('${IMAGE_PATH}Dark_TimeFont.png');
    darkImages['am'] = await _loadImage('${IMAGE_PATH}Dark_AM.png');
    darkImages['pm'] = await _loadImage('${IMAGE_PATH}Dark_PM.png');
    darkImages['24'] = await _loadImage('${IMAGE_PATH}Dark_24.png');
    darkImages['font_large'] =
        await _loadImage('${IMAGE_PATH}Dark_Font_Large.png');
    darkImages['font_small'] =
        await _loadImage('${IMAGE_PATH}Dark_Font_Small.png');

    lightImages['hour'] = await _loadImage('${IMAGE_PATH}Light_Hour.png');
    lightImages['minute'] = await _loadImage('${IMAGE_PATH}Light_Filled.png');
    lightImages['second'] = await _loadImage('${IMAGE_PATH}Light_Second.png');
    lightImages['tnums'] = await _loadImage('${IMAGE_PATH}Light_TimeFont.png');
    lightImages['am'] = await _loadImage('${IMAGE_PATH}Light_AM.png');
    lightImages['pm'] = await _loadImage('${IMAGE_PATH}Light_PM.png');
    lightImages['24'] = await _loadImage('${IMAGE_PATH}Light_24.png');
    lightImages['font_large'] =
        await _loadImage('${IMAGE_PATH}Light_Font_Large.png');
    lightImages['font_small'] =
        await _loadImage('${IMAGE_PATH}Light_Font_Small.png');
    _start();
    isReady = true;
  }

  /// Disposes of the timer
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Starts the internal [_timer].
  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateTime());
  }

  /// Updates the time and then triggers a notification to its listeners
  void _updateTime() {
    now = DateTime.now();
    notifyListeners();
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
