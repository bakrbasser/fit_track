part of 'workout_session_cubit.dart';

@immutable
sealed class WorkoutSessionState {}

final class WorkoutSessionInitial extends WorkoutSessionState {}

final class WorkoutsLoading extends WorkoutSessionState {}

final class Resting extends WorkoutSessionState {}

final class NextExercise extends WorkoutSessionState {
  final Exercise exercise;
  final TrainingDayExercise trainingDayExercise;
  final int index;
  final int totalVolume;

  NextExercise(
    this.totalVolume, {
    required this.exercise,
    required this.trainingDayExercise,
    required this.index,
  });
}

final class FinishedWorkout extends WorkoutSessionState {}

final class SkippedWorkout extends WorkoutSessionState {}
