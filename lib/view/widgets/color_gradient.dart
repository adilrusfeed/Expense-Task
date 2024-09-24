import 'package:flutter/material.dart';

class ColorGradient {
  static LinearGradient cardLineGradient() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 13, 8, 60),
          Color.fromARGB(255, 13, 57, 100),
          Color.fromARGB(255, 8, 10, 76),
        ]);
  }

  static LinearGradient cardGradient() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue.withOpacity(0.01),
          Color.fromARGB(255, 162, 198, 234),
          Color.fromARGB(255, 9, 26, 85),
        ]);
  }
}
