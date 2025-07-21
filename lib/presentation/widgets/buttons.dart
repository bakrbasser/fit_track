import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class Buttons {
  static CostumeButton({
    Color backgroundColor = ColorsManager.green,
    Color foregroundColor = ColorsManager.black,
    required void Function() onPressed,
    required Widget child,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: FontsManager.lexendBold(size: 20),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
