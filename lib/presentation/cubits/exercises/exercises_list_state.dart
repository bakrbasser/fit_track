part of 'exercises_list_cubit.dart';

@immutable
sealed class ExercisesListState {}

final class ExercisesInitial extends ExercisesListState {}

final class ExercisesLoading extends ExercisesListState {}

final class ExercisesLoaded extends ExercisesListState {}

final class EmptyList extends ExercisesListState {}

final class FullList extends ExercisesListState {
  final List<Exercise> exercises;

  FullList({required this.exercises});
}

final class DeletedExercise extends ExercisesListState {
  final List<Exercise> exercises;

  DeletedExercise({required this.exercises});
}

final class Error extends ExercisesListState {
  Error({required this.message});

  final String message;
}
