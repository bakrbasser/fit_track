part of 'exercises_cubit.dart';

@immutable
sealed class ExercisesState {}

final class ExercisesInitial extends ExercisesState {}

final class ExercisesLoading extends ExercisesState {}

final class ExercisesLoaded extends ExercisesState {}

final class AddedExercise extends ExercisesState {
  final List<Exercise> exercises;

  AddedExercise({required this.exercises});
}

final class DeletedExercise extends ExercisesState {
  final List<Exercise> exercises;

  DeletedExercise({required this.exercises});
}

final class Updated extends ExercisesState {
  final List<Exercise> exercises;

  Updated({required this.exercises});
}

final class Error extends ExercisesState {
  Error({required this.message});

  final String message;
}
