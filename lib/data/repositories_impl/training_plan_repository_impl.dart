import 'package:fit_track/data/data_source/DAOs/training_plan_dao.dart';
import 'package:fit_track/data/models/training_plan_model.dart';
import 'package:fit_track/data/models/training_plan_training_day_model.dart';
import 'package:fit_track/domain/entities/training_day.dart';
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

  @override
  Future fetchTrainingPlans() async {
    final plans = await _dao.fetchTrainingPlans();
    _trainingPlans = List.generate(
      plans.length,
      (index) => plans[index].toEntity(),
    );
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
  Future<List<TrainingDay>> fetchPlanTrainingDays({
    required int trainingPlanID,
  }) async {
    final days = await _dao.fetchPlanTrainingDays(
      trainingPlanID: trainingPlanID,
    );
    return List.generate(days.length, (index) => days[index].toEntity());
  }

  @override
  Future linkDayToPlan({
    required TrainingPlanTrainingDay trainingPlanTrainingDay,
  }) async {
    final model = TrainingPlanTrainingDayModel.fromEntity(
      trainingPlanTrainingDay,
    );
    await _dao.linkDayToPlan(model: model);
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
}
