import 'package:fit_track/core/data_sources_consts.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/exercise_model.dart';
import '../app_database.dart';

class ExerciseDao {
  static final ExerciseDao instance = ExerciseDao._internal();

  ExerciseDao._internal();

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<int> insert(ExerciseModel exercise) async {
    final db = await _db;
    return await db.insert(TablesName.exercises, exercise.toJson());
  }

  Future<void> update(ExerciseModel exercise) async {
    final db = await _db;
    await db.update(
      TablesName.exercises,
      exercise.toJson(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _db;

    await db.delete(
      TablesName.goals,
      where: 'exercise_id = ?',
      whereArgs: [id],
    );
    await db.delete(
      TablesName.exerciseLogs,
      where: 'exercise_id = ?',
      whereArgs: [id],
    );
    await db.delete(
      TablesName.trainingDayExercise,
      where: 'exercise_id = ?',
      whereArgs: [id],
    );
    await db.delete(TablesName.exercises, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ExerciseModel>> getAll() async {
    final db = await _db;
    final query = await db.query(TablesName.exercises);
    return query.map((e) => ExerciseModel.fromJson(e)).toList();
  }
}
