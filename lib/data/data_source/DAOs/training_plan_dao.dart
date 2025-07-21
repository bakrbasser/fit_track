import 'package:fit_track/core/data_sources_consts.dart';
import 'package:fit_track/data/data_source/app_database.dart';
import 'package:fit_track/data/models/training_plan_model.dart';
import 'package:fit_track/data/models/training_plan_training_day_model.dart';
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

  Future<int> addTrainingPlan({required TrainingPlanModel trainingPlan}) async {
    final db = await _db;
    return await db.insert(TablesName.trainingPlans, trainingPlan.toJson());
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

  Future<List<int>> fetchPlanTrainingDays({required int trainingPlanID}) async {
    final db = await _db;
    final query = await db.rawQuery(
      '''
    SELECT id
      FROM training_day
          INNER JOIN
          trainingPlan_trainingDay ON training_day.id = trainingDay_id
    WHERE trainingPlan_trainingDay.trainingPlan_id = ?;
''',
      [trainingPlanID],
    );
    return query.map((row) => row['id'] as int).toList();
  }

  Future linkDayToPlan({required TrainingPlanTrainingDayModel model}) async {
    final db = await _db;
    db.insert(TablesName.trainingPlanTrainingDay, model.toJson());
  }

  Future removeLinkDayToPlan({
    required TrainingPlanTrainingDayModel model,
  }) async {
    final db = await _db;
    db.delete(
      TablesName.trainingPlanTrainingDay,
      where: 'trainingDay_id = ? and trainingPlan_id = ?',
      whereArgs: [model.trainingDayId, model.trainingPlanId],
    );
  }

  Future<void> activatePlan({required TrainingPlanModel model}) async {
    final db = await _db;
    db.update(
      TablesName.trainingPlans,
      {'isActivated': true},
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deactivatePlan({required TrainingPlanModel model}) async {
    final db = await _db;
    db.update(
      TablesName.trainingPlans,
      {'isActivated': false},
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }
}
