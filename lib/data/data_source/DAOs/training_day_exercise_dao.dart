import 'package:fit_track/core/data_sources_consts.dart';
import 'package:fit_track/data/data_source/app_database.dart';
import 'package:fit_track/data/models/training_day_exercise_model.dart';
import 'package:sqflite/sqflite.dart';

class TrainingDayExerciseDao {
  TrainingDayExerciseDao._internal();
  static TrainingDayExerciseDao dao = TrainingDayExerciseDao._internal();
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<int> addTrainingDayExercise({
    required TrainingDayExerciseModel model,
  }) async {
    int id = -1;
    try {
      final db = await _db;
      id = await db.insert(TablesName.trainingDayExercise, model.toJson());
    } catch (e) {
      return -1;
    }
    return id;
  }

  Future<void> deleteTrainingDayExercise({
    required int dayId,
    required int exerciseId,
  }) async {
    try {
      final db = await _db;
      await db.delete(
        TablesName.trainingDayExercise,
        where: 'trainingDay_id = ? and exercise_id = ?',
        whereArgs: [dayId, exerciseId],
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<List<TrainingDayExerciseModel>> fetchTrainingDayExercises({
    required int dayId,
  }) async {
    try {
      final db = await _db;
      final exercises = await db.query(
        TablesName.trainingDayExercise,
        where: 'trainingDay_id = ?',
        whereArgs: [dayId],
      );
      return exercises
          .map((json) => TrainingDayExerciseModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
