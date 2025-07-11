import 'package:fit_track/presentation/cubits/exercises/add/add_exercise_cubit.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/cubits/goals/add/goals_add_cubit.dart';
import 'package:fit_track/presentation/cubits/goals/list/goals_list_cubit.dart';
import 'package:fit_track/presentation/cubits/initialization/initialization_cubit.dart';
import 'package:fit_track/presentation/cubits/pages_navigator/pages_navigator_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/add/add_plan_cubit.dart';
import 'package:fit_track/presentation/pages/exercises/add_exercise.dart';
import 'package:fit_track/presentation/pages/exercises/exercises_screen.dart';
import 'package:fit_track/presentation/pages/goals/achieved_goals.dart';
import 'package:fit_track/presentation/pages/goals/add_goal.dart';
import 'package:fit_track/presentation/pages/main_page/main_page.dart';
import 'package:fit_track/presentation/pages/plans/add_plan.dart';
import 'package:fit_track/presentation/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String splashScreen = '/';
  static const String main = '/main';
  static const String exercisesList = '/exercisesList';
  static const String addExercises = '/addExercise';
  static const String addGoal = '/addGoal';
  static const String achievedGoals = '/achievedGoal';
  static const String addPlan = '/addPlan';
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
      case Routes.main:
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => PagesNavigatorCubit()),
                  BlocProvider(create: (context) => ExercisesListCubit()),
                ],
                child: MainPage(),
              ),
        );
      case Routes.exercisesList:
        return MaterialPageRoute(builder: (context) => ExercisesScreen());
      case Routes.addExercises:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AddExerciseCubit(),
                child: AddExercise(),
              ),
        );
      case Routes.addGoal:
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => AddGoalCubit()),
                  BlocProvider(create: (context) => ExercisesListCubit()),
                ],
                child: AddGoal(),
              ),
        );
      case Routes.achievedGoals:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => GoalsListCubit(),
                child: AchievedGoals(),
              ),
        );
      case Routes.addPlan:
        final args = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AddPlanCubit(),
                child: AddPlan(numberOfDays: args),
              ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Placeholder());
    }
  }
}
