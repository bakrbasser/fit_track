import 'package:fit_track/core/database_consts.dart';
import 'package:fit_track/data/data_source/app_database.dart';
import 'package:fit_track/data/models/exercise_log_model.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseLogDao {
  ExerciseLogDao._internal();
  static final ExerciseLogDao instance = ExerciseLogDao._internal();

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<ExerciseLogModel>> fetchLogsByExerciseId(int exerciseId) async {
    final db = await _db;
    final query = await db.query(
      TablesName.exerciseLogs,
      where: 'exercise_id = ?',
      whereArgs: [exerciseId],
    );
    return query.map((e) => ExerciseLogModel.fromJson(e)).toList();
  }

  Future<int> addExerciseLog({required ExerciseLogModel exerciseLog}) async {
    final db = await _db;
    return await db.insert(TablesName.exerciseLogs, exerciseLog.toJson());
  }

  Future<void> updateExerciseLog({
    required ExerciseLogModel exerciseLog,
  }) async {
    final db = await _db;
    await db.update(
      TablesName.exerciseLogs,
      exerciseLog.toJson(),
      where: 'exercise_id = ?',
      whereArgs: [exerciseLog.exerciseId],
    );
  }
}
