import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: FontsManager.lexendRegular(size: 16)),
        backgroundColor: ColorsManager.grey,
      ),
    );
  }
}
