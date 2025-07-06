import 'package:fit_track/core/presentation/resources/app_theme.dart';
import 'package:fit_track/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: SplashScreen(), theme: AppTheme.appTheme));
}
