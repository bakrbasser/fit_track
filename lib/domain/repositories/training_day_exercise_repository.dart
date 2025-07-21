import 'package:fit_track/domain/entities/training_day_exercise.dart';

abstract class TrainingDayExerciseRepository {
  Future addTrainingDayExercise({
    required TrainingDayExercise trainingDayExercise,
  });
  Future deleteTrainingDayExercise({
    required int dayId,
    required int exerciseId,
  });

  Future<List<TrainingDayExercise>> fetchTrainingDayExercises({
    required int dayId,
  });
}
