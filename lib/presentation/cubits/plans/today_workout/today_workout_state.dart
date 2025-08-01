part of 'today_workout_cubit.dart';

@immutable
sealed class TodayWorkoutState {}

final class TodayWorkoutInitial extends TodayWorkoutState {}

final class FetchedTodayWorkout extends TodayWorkoutState {
  final TrainingDay trainingDay;
  final int trainingsCount;

  FetchedTodayWorkout({
    required this.trainingDay,
    required this.trainingsCount,
  });
}

final class NoActivePlan extends TodayWorkoutState {}
