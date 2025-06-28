import 'package:fit_track/domain/entities/training_plan_training_day.dart';

abstract class TrainingPlanTrainingDayRepository {
  Future fetchPlanTrainingDays({
    required TrainingPlanTrainingDay trainingPlanTrainingDay,
  });
  Future addTrainingPlanTrainingDays({
    required TrainingPlanTrainingDay trainingPlanTrainingDay,
  });
  Future deleteTrainingPlanTrainingDays({
    required TrainingPlanTrainingDay trainingPlanTrainingDay,
  });
}
