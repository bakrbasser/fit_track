import 'package:fit_track/core/database_consts.dart';
import 'package:fit_track/data/data_source/app_database.dart';
import 'package:fit_track/data/models/exercise_model.dart';
import 'package:fit_track/data/models/training_day_exercise_model.dart';
import 'package:fit_track/data/models/training_day_model.dart';
import 'package:sqflite/sqflite.dart';

class TrainingDayDao {
  TrainingDayDao._internal();
  static final TrainingDayDao instance = TrainingDayDao._internal();

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<TrainingDayModel>> fetchTrainingDays() async {
    final db = await _db;
    final query = await db.query(TablesName.trainingDays);
    return query.map((e) => TrainingDayModel.fromJson(e)).toList();
  }

  Future<void> updateTrainingDay({
    required TrainingDayModel trainingDay,
  }) async {
    final db = await _db;
    await db.update(
      TablesName.trainingDays,
      trainingDay.toJson(),
      where: 'id = ?',
      whereArgs: [trainingDay.id],
    );
  }

  Future<void> deleteTrainingDay({required int trainingDayID}) async {
    final db = await _db;
    await db.delete(
      TablesName.trainingDays,
      where: 'id = ?',
      whereArgs: [trainingDayID],
    );
  }

  Future<void> addTrainingDay({required TrainingDayModel trainingDay}) async {
    final db = await _db;
    await db.insert(TablesName.trainingDays, trainingDay.toJson());
  }

  Future addTrainingDayExercises({
    required TrainingDayExerciseModel trainingDayExercise,
  }) async {
    final db = await _db;
    await db.insert(
      TablesName.trainingDayExercise,
      trainingDayExercise.toJson(),
    );
  }

  Future removeTrainingDayExercises({
    required TrainingDayExerciseModel trainingDayExercise,
  }) async {
    final db = await _db;
    await db.delete(
      TablesName.trainingDayExercise,
      where: 'trainingDay_id = ? and exercise_id = ?',
      whereArgs: [
        trainingDayExercise.trainingDayId,
        trainingDayExercise.exerciseId,
      ],
    );
  }

  Future<List<DetailedExerciseModel>> fetchTrainingDayExercises({
    required int trainingDayID,
  }) async {
    final db = await _db;
    final query = await db.rawQuery(
      '''
    SELECT *
      FROM exercise
          INNER JOIN
          trainingDay_exercise ON exercise.id = exercise_id
    WHERE trainingDay_id = ?;
''',
      [trainingDayID],
    );
    return query.map((e) => DetailedExerciseModel.fromJson(e)).toList();
  }
}
