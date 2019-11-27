import 'package:flutter/material.dart';

const PURE_WATER = BoxDecoration(
  gradient: RadialGradient(
    radius: 1,
    center: Alignment.center,
    stops: [0.0, 1],
    colors: [
      Color.fromARGB(255, 191, 227, 238),
      Color.fromARGB(255, 123, 169, 186),
    ],
  ),
);

const VICIOUS_STANCE = BoxDecoration(
  gradient: RadialGradient(
    radius: 3,
    center: Alignment.topRight,
    stops: [0.0, 1],
    colors: [
      Color.fromARGB(255, 41, 50, 60),
      Color.fromARGB(255, 72, 85, 99),
    ],
  ),
);

const AQUA_SPLASH = BoxDecoration(
  gradient: RadialGradient(
    radius: 3,
    center: Alignment.topRight,
    stops: [0.0, 1],
    colors: [
      Color.fromARGB(255, 128, 208, 199),
      Color.fromARGB(255, 19, 84, 122),
    ],
  ),
);

const JUICY_PEACH = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, 1],
    colors: [
      Color.fromARGB(255, 255, 236, 210),
      Color.fromARGB(255, 252, 182, 159),
    ],
  ),
);

const COCHITI_LAKE = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, 1],
    colors: [
      Color.fromARGB(255, 147, 165, 207),
      Color.fromARGB(255, 228, 239, 233),
    ],
  ),
);
