part of 'pages_navigator_cubit.dart';

@immutable
sealed class PagesNavigatorState {}

final class NavigatingHome extends PagesNavigatorState {}

final class NavigatingExercises extends PagesNavigatorState {}

final class NavigatingPlans extends PagesNavigatorState {}

final class NavigatingGoals extends PagesNavigatorState {}
