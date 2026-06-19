import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle displayLarge = GoogleFonts.cormorantGaramond(
    fontSize: 62,
    fontWeight: FontWeight.w300,
    color: AppColors.darkText,
    letterSpacing: 2,
    height: 1.2,
  );

  static TextStyle displayMedium = GoogleFonts.cormorantGaramond(
    fontSize: 48,
    fontWeight: FontWeight.w300,
    color: AppColors.darkText,
    letterSpacing: 1.5,
    height: 1.2,
  );

  static TextStyle headingLarge = GoogleFonts.cormorantGaramond(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    letterSpacing: 1,
    height: 1.3,
  );

  static TextStyle headingMedium = GoogleFonts.cormorantGaramond(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    letterSpacing: 0.5,
    height: 1.3,
  );

  static TextStyle headingSmall = GoogleFonts.cormorantGaramond(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    height: 1.3,
  );

  static TextStyle bodyLarge = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.darkText,
    height: 1.75,
  );

  static TextStyle bodyMedium = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkText,
    height: 1.6,
  );

  static TextStyle bodyMuted = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedText,
    height: 1.6,
  );

  static TextStyle label = GoogleFonts.lato(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.mutedText,
    letterSpacing: 2.5,
  );

  static TextStyle navLink = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    letterSpacing: 1.8,
  );

  static TextStyle price = GoogleFonts.cormorantGaramond(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
  );
}
