import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pages_navigator_state.dart';

class PagesNavigatorCubit extends Cubit<PagesNavigatorState> {
  PagesNavigatorCubit() : super(NavigatingHome());

  void navigate(int pageIdx) {
    switch (pageIdx) {
      case 0:
        emit(NavigatingHome());
        break;
      case 1:
        emit(NavigatingExercises());
        break;
      case 2:
        emit(NavigatingPlans());
        break;
      case 3:
        emit(NavigatingGoals());
        break;
      default:
    }
  }
}
