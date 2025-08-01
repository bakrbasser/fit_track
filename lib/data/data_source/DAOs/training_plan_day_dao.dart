import 'package:fit_track/core/data_sources_consts.dart';
import 'package:fit_track/data/data_source/app_database.dart';
import 'package:fit_track/data/models/training_plan_training_day_model.dart';
import 'package:sqflite/sqflite.dart';

class TrainingPlanDayDao {
  TrainingPlanDayDao._internal();
  static TrainingPlanDayDao dao = TrainingPlanDayDao._internal();
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<int>> fetchPlanTrainingDaysIds({
    required int trainingPlanID,
  }) async {
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

  Future<void> removeAllPlanDayLinks(int planId) async {
    final db = await _db;
    db.delete(
      TablesName.trainingPlanTrainingDay,
      where: 'trainingPlan_id = ?',
      whereArgs: [planId],
    );
  }
}
