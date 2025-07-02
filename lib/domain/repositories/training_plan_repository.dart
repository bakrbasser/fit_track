import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/domain/entities/training_plan_training_day.dart';

abstract class TrainingPlanRepository {
  Future<List<TrainingPlan>> fetchTrainingPlans();
  Future addTrainingPlan({required TrainingPlan trainingPlan});
  Future updateTrainingPlan({required TrainingPlan trainingPlan});
  Future deleteTrainingPlan({required int trainingPlanId});
  Future<List<TrainingDay>> fetchPlanTrainingDays({
    required int trainingPlanID,
  });
  Future linkDayToPlan({
    required TrainingPlanTrainingDay trainingPlanTrainingDay,
  });
  Future removeLinkDayToPlan({
    required TrainingPlanTrainingDay trainingPlanTrainingDay,
  });
}
