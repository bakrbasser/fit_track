import 'package:fit_track/core/presentation/resources/app_theme.dart';
import 'package:fit_track/presentation/pages/exercises/exercises_list.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: ExercisesList(), theme: AppTheme.appTheme));
}
