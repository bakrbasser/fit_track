import 'package:fit_track/data/data_source/DAOs/exercise_dao.dart';
import 'package:fit_track/data/models/exercise_model.dart';
import 'package:fit_track/domain/entities/exercise.dart';

import '../../domain/repositories/exercises_repository.dart';

class ExercisesRepositoryImpl implements ExercisesRepository {
  final ExerciseDao _dao = ExerciseDao.instance;
  List<Exercise> _exercises = [];

  @override
  List<Exercise> get exercises => _exercises;

  @override
  Future<void> addExercise({required Exercise exercise}) async {
    await _dao.insert(ExerciseModel.fromEntity(exercise));
    _exercises.add(exercise);
  }

  @override
  Future<void> deleteExercise({required int exerciseID}) async {
    await _dao.delete(exerciseID);
    _exercises.removeWhere((element) => element.id == exerciseID);
  }

  @override
  Future<void> updateExercise({required Exercise exercise}) async {
    await _dao.update(ExerciseModel.fromEntity(exercise));
    final idx = _exercises.indexWhere((element) => element.id == exercise.id);
    _exercises[idx] = exercise;
  }

  @override
  Future fetchAllExercises() async {
    final models = await _dao.getAll();
    _exercises = models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Exercise> fetchLastExercise() async {
    final model = await _dao.getLast();
    return model.toEntity();
  }
}
