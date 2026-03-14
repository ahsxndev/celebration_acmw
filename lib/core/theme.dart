import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors mapped from the Figma design
  static const Color primaryPurple = Color(0xFF2D104E); // Deep purple background
  static const Color lightLavender = Color(0xFFF4EBFB); // Light background
  static const Color accentMagenta = Color(0xFFB3137A); // Buttons & Tags
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color white = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: white,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(color: primaryPurple, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.poppins(color: textDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentMagenta,
          foregroundColor: white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}