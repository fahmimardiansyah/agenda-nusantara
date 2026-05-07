import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color.fromARGB(255, 61, 32, 226);

  static const secondary = Color.fromARGB(255, 24, 97, 255);

  static const Color background = Color(0xFF000000);

  static const Color card = Color(0xFF0F0F0F);

  static const Color success = Color(0xFF22C55E);

    static const Color warning = Color(0xFFF59E0B);

  static const Color danger = Color(0xFFEF4444);

  static const Color white = Color(0xFFF9FAFB);

  static const Color grey = Color(0xFF9CA3AF);
  
    // =========================
  // GRADIENTS
  // =========================

  static const LinearGradient primaryGradient =
      LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,

    colors: [
      Color(0xFFB066FF),
      Color(0xFF7C3AED),
      Color.fromARGB(255, 51, 29, 150),
    ],
  );

  static const LinearGradient blueGradient =
      LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,

    colors: [
      Color(0xFF60A5FA),
      Color(0xFF2563EB),
    ],
  );

  static const LinearGradient darkGradient =
      LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,

    colors: [
      Color(0xFF111111),
      Color(0xFF1E1E1E),
    ],
  );
}
