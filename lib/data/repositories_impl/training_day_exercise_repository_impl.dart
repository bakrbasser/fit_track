import 'package:fit_track/data/data_source/DAOs/training_day_exercise_dao.dart';
import 'package:fit_track/data/models/training_day_exercise_model.dart';
import 'package:fit_track/domain/entities/training_day_exercise.dart';
import 'package:fit_track/domain/repositories/training_day_exercise_repository.dart';

class TrainingDayExerciseRepositoryImpl
    implements TrainingDayExerciseRepository {
  TrainingDayExerciseRepositoryImpl._priv();
  static TrainingDayExerciseRepositoryImpl instance =
      TrainingDayExerciseRepositoryImpl._priv();

  final dao = TrainingDayExerciseDao.dao;

  @override
  Future<int> addTrainingDayExercise({
    required TrainingDayExercise trainingDayExercise,
  }) async {
    return dao.addTrainingDayExercise(
      model: TrainingDayExerciseModel.fromEntity(trainingDayExercise),
    );
  }

  @override
  Future deleteTrainingDayExercise({
    required int dayId,
    required int exerciseId,
  }) async {
    dao.deleteTrainingDayExercise(dayId: dayId, exerciseId: exerciseId);
  }
}
