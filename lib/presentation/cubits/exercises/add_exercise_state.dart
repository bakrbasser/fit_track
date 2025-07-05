import 'package:fit_track/domain/entities/exercise.dart';
import 'package:meta/meta.dart';

@immutable
sealed class AddExerciseState {}

final class AddExerciseInitial extends AddExerciseState {}

final class AddedExercise extends AddExerciseState {
  final Exercise exercise;

  AddedExercise({required this.exercise});
}

final class Error extends AddExerciseState {
  final String message;

  Error({required this.message});
}
