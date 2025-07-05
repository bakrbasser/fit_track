part of 'exercises_list_cubit.dart';

@immutable
sealed class ExercisesListState {}

final class ExercisesInitial extends ExercisesListState {}

final class Loading extends ExercisesListState {}

final class EmptyList extends ExercisesListState {}

final class FullList extends ExercisesListState {
  final List<Exercise> exercises;

  FullList({required this.exercises});
}
