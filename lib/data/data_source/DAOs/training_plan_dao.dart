import 'package:fit_track/core/database_consts.dart';
import 'package:fit_track/data/data_source/app_database.dart';
import 'package:fit_track/data/models/training_plan_model.dart';
import 'package:sqflite/sqflite.dart';

class TrainingPlanDAO {
  TrainingPlanDAO._internal();
  static final TrainingPlanDAO instance = TrainingPlanDAO._internal();
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<TrainingPlanModel>> fetchTrainingPlans() async {
    final db = await _db;
    final query = await db.query(TablesName.trainingPlans);
    return query.map((e) => TrainingPlanModel.fromJson(e)).toList();
  }

  Future addTrainingPlan({required TrainingPlanModel trainingPlan}) async {
    final db = await _db;
    await db.insert(TablesName.trainingPlans, trainingPlan.toJson());
  }

  Future deleteTrainingPlan({required int trainingPlanId}) async {
    final db = await _db;
    await db.delete(
      TablesName.trainingPlans,
      where: 'id = ?',
      whereArgs: [trainingPlanId],
    );
  }

  Future updateTrainingPlan({required TrainingPlanModel trainingPlan}) async {
    final db = await _db;
    await db.update(
      TablesName.trainingPlans,
      trainingPlan.toJson(),
      where: 'id = ?',
      whereArgs: [trainingPlan.id],
    );
  }
}
