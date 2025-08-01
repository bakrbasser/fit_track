import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pages_navigator_state.dart';

class PagesNavigatorCubit extends Cubit<PagesNavigatorState> {
  PagesNavigatorCubit() : super(NavigatingHome());

  void navigate(int index) {
    emit(switch (index) {
      0 => NavigatingHome(),
      1 => NavigatingExercises(),
      2 => NavigatingPlans(),
      3 => NavigatingGoals(),
      _ => NavigatingHome(),
    });
  }
}
