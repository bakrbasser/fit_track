import 'package:fit_track/data/data_source/DAOs/exercise_dao.dart';
import 'package:fit_track/data/models/exercise_model.dart';
import 'package:fit_track/domain/entities/exercise.dart';

import '../../domain/repositories/exercises_repository.dart';

class ExerciseRepositoryImpl implements ExercisesRepository {
  final ExerciseDao _dao = ExerciseDao.instance;

  @override
  Future<void> addExercise({required Exercise exercise}) async {
    await _dao.insert(ExerciseModel.fromEntity(exercise));
  }

  @override
  Future<void> deleteExercise({required int exerciseID}) async {
    await _dao.delete(exerciseID);
  }

  @override
  Future<void> updateExercise({required Exercise exercise}) async {
    await _dao.update(ExerciseModel.fromEntity(exercise));
  }

  @override
  Future<List<Exercise>> fetchAllExercises() async {
    final models = await _dao.getAll();
    return models.map((e) => e.toEntity()).toList();
  }
}
