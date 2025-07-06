import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/cubits/initialization/initialization_cubit.dart';
import 'package:fit_track/presentation/pages/exercises/exercises_screen.dart';
import 'package:fit_track/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String splashScreen = '/';
  static const String exercisesScreen = '/exercisesScreen';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => InitializationCubit(),
                child: SplashScreen(),
              ),
        );
      case Routes.exercisesScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => ExercisesListCubit(),
                child: ExercisesScreen(),
              ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Placeholder());
    }
  }
}
