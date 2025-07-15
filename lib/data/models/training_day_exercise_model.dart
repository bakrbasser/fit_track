import '../../domain/entities/training_day_exercise.dart';

class TrainingDayExerciseModel {
  final int? trainingDayId;
  final int exerciseId;
  final int sets;
  final int reps;

  TrainingDayExerciseModel({
    required this.trainingDayId,
    required this.exerciseId,
    required this.sets,
    required this.reps,
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

  factory TrainingDayExerciseModel.fromEntity(TrainingDayExercise entity) =>
      TrainingDayExerciseModel(
        trainingDayId: entity.trainingDayId,
        exerciseId: entity.exerciseId,
        sets: entity.sets,
        reps: entity.reps,
      );

  TrainingDayExercise toEntity() => TrainingDayExercise(
    trainingDayId: trainingDayId,
    exerciseId: exerciseId,
    sets: sets,
    reps: reps,
  );
}
