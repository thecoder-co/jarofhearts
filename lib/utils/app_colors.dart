import 'package:flutter/material.dart';

class AppColors {
  static Color pastelBlue = const Color(0xff394053);
  static Color darkLiver = const Color(0xff4e4a59);
  static Color graniteGrey = const Color(0xff6e6362);
  static Color artichoke = const Color(0xff839073);
  static Color asparagus = const Color(0xff7cae7a);
  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 33, 163, 243),
      Color.fromARGB(255, 72, 195, 76),
    ],
  );
}
