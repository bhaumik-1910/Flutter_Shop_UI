import 'package:flutter/material.dart';

/// Centralized design tokens and color palette for the Coffee Shop app.
abstract class AppColors {
  // Brand & Accent Colors
  static const Color primary = Color(0xFFE57734);
  static const Color primaryLight = Color(0xFFFF9453);
  static const Color primaryDark = Color(0xFFB65D24);
  static const Color accentAmber = Color(0xFFFFB038);
  static const Color goldStar = Color(0xFFFFC107);

  // Background & Surfaces
  static const Color background = Color(0xFF0F1012);
  static const Color surfaceDark = Color(0xFF1B1D20);
  static const Color cardSurface = Color(0xFF222428);
  static const Color cardSurfaceLight = Color(0xFF2C2F34);
  static const Color searchFieldBg = Color(0xFF292C31);
  static const Color bottomBarBg = Color(0xFF181A1D);

  // Borders & Dividers
  static const Color borderLight = Color(0x26FFFFFF); // 15% White
  static const Color borderSubtle = Color(0x14FFFFFF); // 8% White
  static const Color divider = Color(0x1FFFFFFF); // 12% White

  // Typography Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% White
  static const Color textMuted = Color(0x80FFFFFF); // 50% White
  static const Color textDisabled = Color(0x4DFFFFFF); // 30% White

  // Functional Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color heartRed = Color(0xFFFF4B6E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF18A49), Color(0xFFE57734), Color(0xFFB65D24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF2A2D33), Color(0xFF1E2024)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkHeroGradient = LinearGradient(
    colors: [Colors.transparent, Color(0xCC0F1012), Color(0xFF0F1012)],
    stops: [0.0, 0.6, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
