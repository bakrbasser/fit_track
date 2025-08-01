import 'package:fit_track/domain/entities/training_plan.dart';

abstract class TrainingPlanRepository {
  Future fetchTrainingPlans();
  Future addTrainingPlan({required TrainingPlan trainingPlan});
  Future updateTrainingPlan({required TrainingPlan trainingPlan});
  Future deleteTrainingPlan({required int trainingPlanId});

  Future<void> activatePlan({required TrainingPlan plan});
  Future<void> deactivatePlan();

  Future<int?> getPlanNextWorkout(int planId);
  Future<void> setPlanNextWorkout();
}
