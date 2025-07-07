import 'package:fit_track/core/presentation/resources/app_theme.dart';
import 'package:fit_track/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.exercisesList,
      theme: AppTheme.darkTheme,
    ),
  );
}
