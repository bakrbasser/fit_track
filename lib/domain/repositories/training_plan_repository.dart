import 'package:fit_track/domain/entities/training_plan.dart';

abstract class TrainingPlanRepository {
  Future fetchTrainingPlans();
  Future addTrainingPlan({required TrainingPlan trainingPlan});
  Future updateTrainingPlan({required TrainingPlan trainingPlan});
  Future deleteTrainingPlan({required int trainingPlanId});
  Future fetchPlanTrainingDays({required int trainingPlanID});
  Future linkDayToPlan({
    required int trainingPlanID,
    required int trainingDayID,
  });
  Future removeLinkDayToPlan({
    required int trainingPlanID,
    required int trainingDayID,
  });
}
