import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized Typography system using GoogleFonts Outfit and Pacifico.
abstract class AppTypography {
  // Display & Headers
  static TextStyle displayPacifico({
    double fontSize = 48,
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.pacifico(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle headingLarge({
    double fontSize = 28,
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = -0.5,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: 1.2,
    );
  }

  static TextStyle headingMedium({
    double fontSize = 22,
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.25,
    );
  }

  static TextStyle headingSmall({
    double fontSize = 18,
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Subtitles & Body
  static TextStyle subtitle({
    double fontSize = 15,
    Color color = AppColors.textSecondary,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.4,
    );
  }

  static TextStyle body({
    double fontSize = 14,
    Color color = AppColors.textSecondary,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle caption({
    double fontSize = 12,
    Color color = AppColors.textMuted,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Price & Buttons
  static TextStyle price({
    double fontSize = 20,
    Color color = AppColors.primary,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle button({
    double fontSize = 16,
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.bold,
    double letterSpacing = 0.5,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}
