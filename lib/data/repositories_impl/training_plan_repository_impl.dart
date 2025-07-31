import 'package:fit_track/data/data_source/DAOs/training_plan_dao.dart';
import 'package:fit_track/data/data_source/DAOs/training_plan_day_dao.dart';
import 'package:fit_track/data/data_source/hive.dart';
import 'package:fit_track/data/models/training_plan_model.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/domain/repositories/training_plan_repository.dart';

class TrainingPlanRepositoryImpl implements TrainingPlanRepository {
  TrainingPlanRepositoryImpl._priv();

  static TrainingPlanRepositoryImpl instance =
      TrainingPlanRepositoryImpl._priv();

  // ignore: non_constant_identifier_names
  final TrainingPlanDAO _planDAO = TrainingPlanDAO.instance;
  final TrainingPlanDayDao _dayPlanDAO = TrainingPlanDayDao.dao;

  List<TrainingPlan> _trainingPlans = [];

  List<TrainingPlan> get trainingPlans => _trainingPlans;

  TrainingPlan? activePlan;

  @override
  Future fetchTrainingPlans() async {
    final plans = await _planDAO.fetchTrainingPlans();
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
    int id = await _planDAO.addTrainingPlan(trainingPlan: model);
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
    await _planDAO.deleteTrainingPlan(trainingPlanId: trainingPlanId);
    _trainingPlans.removeWhere((plan) => plan.id == trainingPlanId);
  }

  @override
  Future<void> updateTrainingPlan({required TrainingPlan trainingPlan}) async {
    final model = TrainingPlanModel.fromEntity(trainingPlan);
    await _planDAO.updateTrainingPlan(trainingPlan: model);

    final index = _trainingPlans.indexWhere((p) => p.id == trainingPlan.id);
    if (index != -1) {
      _trainingPlans[index] = trainingPlan;
    }
  }

  @override
  Future<void> activatePlan({required TrainingPlan plan}) async {
    final model = TrainingPlanModel.fromEntity(plan);
    if (activePlan != null) {
      await deactivatePlan();
    }
    await _planDAO.activatePlan(model: model);
    activePlan = plan;
    plan.isActivated = true;
  }

  @override
  Future<void> deactivatePlan() async {
    if (activePlan != null) {
      final model = TrainingPlanModel.fromEntity(activePlan!);
      await _planDAO.deactivatePlan(model: model);
      activePlan!.isActivated = false;
      activePlan = null;
    }
  }

  @override
  Future<int?> getPlanNextWorkout(int planId) async {
    final id = await NextDayDataSource.instance.getPlanNextDayId(planId);
    if (id == null) {
      final days = await _dayPlanDAO.fetchPlanTrainingDaysIds(
        trainingPlanID: activePlan!.id!,
      );
      await NextDayDataSource.instance.setPlanNextDayId(planId, days.first);
      return days.first;
    } else {
      return id;
    }
  }

  @override
  Future<void> setPlanNextWorkout() async {
    final id = await NextDayDataSource.instance.getPlanNextDayId(
      activePlan!.id!,
    );
    final days = await _dayPlanDAO.fetchPlanTrainingDaysIds(
      trainingPlanID: activePlan!.id!,
    );
    var currentDayIndex = days.indexOf(id!);
    if (currentDayIndex == days.length - 1) {
      await NextDayDataSource.instance.setPlanNextDayId(
        activePlan!.id!,
        days.first,
      );
    } else {
      await NextDayDataSource.instance.setPlanNextDayId(
        activePlan!.id!,
        days[currentDayIndex + 1],
      );
    }
  }
}
