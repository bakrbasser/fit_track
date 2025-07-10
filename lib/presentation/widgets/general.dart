import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class NoElements extends StatelessWidget {
  const NoElements({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.5),
      child: Text(
        message,
        style: FontsManager.lexendMedium(size: 22),
        textAlign: TextAlign.center,
      ),
    );
  }
}
