import '../../domain/entities/training_day_exercise.dart';

class TrainingDayExerciseModel extends TrainingDayExercise {
  TrainingDayExerciseModel({
    required super.trainingDayId,
    required super.exerciseId,
    required super.sets,
    required super.reps,
  });

  factory TrainingDayExerciseModel.fromJson(Map<String, dynamic> json) =>
      TrainingDayExerciseModel(
        trainingDayId: json['trainingDay_id'],
        exerciseId: json['exercise_id'],
        sets: json['sets'],
        reps: json['reps'],
      );

  Map<String, dynamic> toJson() => {
    'trainingDay_id': trainingDayId,
    'exercise_id': exerciseId,
    'sets': sets,
    'reps': reps,
  };
}
