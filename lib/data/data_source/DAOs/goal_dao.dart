import 'package:fit_track/core/data_sources_consts.dart';
import 'package:fit_track/data/data_source/app_database.dart';
import 'package:fit_track/data/models/goal_model.dart';
import 'package:sqflite/sqflite.dart';

class GoalDao {
  GoalDao._internal();
  static final GoalDao instance = GoalDao._internal();
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<GoalModel>> fetchGoals() async {
    final db = await _db;
    final query = await db.query(TablesName.goals);
    return query.map((e) => GoalModel.fromJson(e)).toList();
  }

  Future<int> addGoal({required GoalModel goal}) async {
    final db = await _db;
    return await db.insert(TablesName.goals, goal.toJson());
  }

  Future deleteGoal({required int goalId}) async {
    final db = await _db;
    await db.delete(TablesName.goals, where: 'id = ?', whereArgs: [goalId]);
  }

  Future updateGoal({required GoalModel goal}) async {
    final db = await _db;
    await db.update(
      TablesName.goals,
      goal.toJson(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }
}
