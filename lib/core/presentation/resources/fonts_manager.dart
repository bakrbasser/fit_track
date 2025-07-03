import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontsManager {
  static TextStyle lexendBold({double size = 48, Color color = Colors.white}) =>
      GoogleFonts.lexend(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      );
  static TextStyle lexendRegular({
    double size = 16,
    Color color = Colors.white,
  }) => GoogleFonts.lexend(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.normal,
  );
}
