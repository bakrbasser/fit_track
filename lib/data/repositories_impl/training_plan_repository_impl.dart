import 'package:fit_track/data/data_source/DAOs/training_plan_dao.dart';
import 'package:fit_track/data/data_source/hive.dart';
import 'package:fit_track/data/models/training_plan_model.dart';
import 'package:fit_track/data/models/training_plan_training_day_model.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/domain/entities/training_plan_training_day.dart';
import 'package:fit_track/domain/repositories/training_plan_repository.dart';

class TrainingPlanRepositoryImpl implements TrainingPlanRepository {
  TrainingPlanRepositoryImpl._priv();

  static TrainingPlanRepositoryImpl instance =
      TrainingPlanRepositoryImpl._priv();

  final TrainingPlanDAO _dao = TrainingPlanDAO.instance;

  List<TrainingPlan> _trainingPlans = [];

  List<TrainingPlan> get trainingPlans => _trainingPlans;

  TrainingPlan? activePlan;

  @override
  Future fetchTrainingPlans() async {
    final plans = await _dao.fetchTrainingPlans();
    _trainingPlans = List.generate(
      plans.length,
      (index) => plans[index].toEntity(),
    );
    for (var i = 0; i < _trainingPlans.length; i++) {
      if (_trainingPlans[i].isActivated) {
        activePlan = _trainingPlans[i];
        break;
      }
    }
  }

  @override
  Future addTrainingPlan({required TrainingPlan trainingPlan}) async {
    final model = TrainingPlanModel.fromEntity(trainingPlan);
    int id = await _dao.addTrainingPlan(trainingPlan: model);
    _trainingPlans.add(
      TrainingPlan(
        id: id,
        name: trainingPlan.name,
        description: trainingPlan.description,
        icon: trainingPlan.icon,
        isActivated: trainingPlan.isActivated,
      ),
    );
  }

  @override
  Future<void> deleteTrainingPlan({required int trainingPlanId}) async {
    await _dao.deleteTrainingPlan(trainingPlanId: trainingPlanId);
    _trainingPlans.removeWhere((plan) => plan.id == trainingPlanId);
  }

  @override
  Future<void> updateTrainingPlan({required TrainingPlan trainingPlan}) async {
    final model = TrainingPlanModel.fromEntity(trainingPlan);
    await _dao.updateTrainingPlan(trainingPlan: model);

    final index = _trainingPlans.indexWhere((p) => p.id == trainingPlan.id);
    if (index != -1) {
      _trainingPlans[index] = trainingPlan;
    }
  }

  @override
  Future<List<int>> fetchPlanTrainingDaysIds({
    required int trainingPlanID,
  }) async {
    final days = await _dao.fetchPlanTrainingDays(
      trainingPlanID: trainingPlanID,
    );
    return days;
  }

  @override
  Future linkDaysToPlan({required List<int> daysID}) async {
    for (var i = 0; i < daysID.length; i++) {
      final model = TrainingPlanTrainingDayModel(
        trainingPlanId: _trainingPlans.last.id!,
        trainingDayId: daysID[i],
      );
      await _dao.linkDayToPlan(model: model);
    }
  }

  @override
  Future removeLinkDayToPlan({
    required TrainingPlanTrainingDay trainingPlanTrainingDay,
  }) async {
    final model = TrainingPlanTrainingDayModel.fromEntity(
      trainingPlanTrainingDay,
    );
    await _dao.removeLinkDayToPlan(model: model);
  }

  @override
  Future<void> activatePlan({required TrainingPlan plan}) async {
    final model = TrainingPlanModel.fromEntity(plan);
    if (activePlan != null) {
      await deactivatePlan();
    }
    await _dao.activatePlan(model: model);
    activePlan = plan;
    plan.isActivated = true;
  }

  @override
  Future<void> deactivatePlan() async {
    if (activePlan != null) {
      final model = TrainingPlanModel.fromEntity(activePlan!);
      await _dao.deactivatePlan(model: model);
      activePlan!.isActivated = false;
      activePlan = null;
    }
  }

  @override
  Future<int?> getPlanNextWorkout(int planId) async {
    final id = await NextDayDataSource.instance.getPlanNextDayId(planId);
    if (id == null) {
      final days = await fetchPlanTrainingDaysIds(
        trainingPlanID: activePlan!.id!,
      );
      await setPlanNextWorkout(planId, days.first);
      return days.first;
    } else {
      return id;
    }
  }

  @override
  Future<void> setPlanNextWorkout(int planId, int dayId) async {
    //TODO
    await NextDayDataSource.instance.setPlanNextDayId(planId, dayId);
  }
}
