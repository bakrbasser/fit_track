import 'package:flutter/material.dart';

// class FontsManager {
//   static TextStyle lexendBold({double size = 48, Color color = Colors.white}) =>
//       GoogleFonts.lexend(
//         color: color,
//         fontSize: size,
//         fontWeight: FontWeight.bold,
//       );
//   static TextStyle lexendRegular({
//     double size = 16,
//     Color color = Colors.white,
//   }) => GoogleFonts.lexend(
//     color: color,
//     fontSize: size,
//     fontWeight: FontWeight.normal,
//   );
//   static TextStyle lexendMedium({
//     double size = 16,
//     Color color = Colors.white,
//   }) => GoogleFonts.lexend(
//     color: color,
//     fontSize: size,
//     fontWeight: FontWeight.w600,
//   );
// }

class FontsManager {
  static TextStyle lexendBold({double size = 48, Color color = Colors.white}) =>
      TextStyle(fontSize: size, color: color);
  static TextStyle lexendRegular({
    double size = 16,
    Color color = Colors.white,
  }) => TextStyle(fontSize: size, color: color);
  static TextStyle lexendMedium({
    double size = 16,
    Color color = Colors.white,
  }) => TextStyle(fontSize: size, color: color);
}
