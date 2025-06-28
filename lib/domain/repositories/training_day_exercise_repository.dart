import 'package:fit_track/domain/entities/training_day_exercise.dart';

abstract class TrainingDayExerciseRepository {
  Future addTrainingDayExercise({
    required TrainingDayExercise trainingDayExercise,
  });
  Future deleteTrainingDayExercise({required int trainingDayExerciseId});
  Future updateTrainingDayExercise({
    required TrainingDayExercise trainingDayExercise,
  });
}
