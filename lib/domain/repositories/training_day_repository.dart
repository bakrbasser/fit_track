import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/entities/training_day_exercise.dart';

abstract class TrainingDayRepository {
  Future<List<TrainingDay>> fetchTrainingDays();
  Future<void> updateTrainingDay({required TrainingDay trainingDay});
  Future<void> deleteTrainingDay({required int trainingDayID});
  Future<void> addTrainingDay({required TrainingDay trainingDay});
  Future addTrainingDayExercises({
    required TrainingDayExercise trainingDayExercise,
  });
  Future removeTrainingDayExercises({
    required TrainingDayExercise trainingDayExercise,
  });
  Future<List<DetailedExercise>> fetchTrainingDayExercises({
    required int trainingDayID,
  });
}
