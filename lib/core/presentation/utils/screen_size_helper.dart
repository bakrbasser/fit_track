import 'package:flutter/material.dart';

class ScreenSizeHelper {
  // ignore: non_constant_identifier_names
  static double height_P(BuildContext context, double portion) {
    return MediaQuery.sizeOf(context).height * portion;
  }

  // ignore: non_constant_identifier_names
  static double width_P(BuildContext context, double portion) {
    return MediaQuery.sizeOf(context).width * portion;
  }
}
