import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:flutter/material.dart';

class NoElements extends StatelessWidget {
  const NoElements({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenSizeHelper.height_P(context, 0.2)),
      child: Text(
        message,
        style: FontsManager.lexendMedium(size: 22),
        textAlign: TextAlign.center,
      ),
    );
  }
}
