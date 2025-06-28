import '../../domain/entities/training_plan_training_day.dart';

class TrainingPlanTrainingDayModel extends TrainingPlanTrainingDay {
  TrainingPlanTrainingDayModel({
    required super.trainingPlanId,
    required super.trainingDayId,
  });

  factory TrainingPlanTrainingDayModel.fromJson(Map<String, dynamic> json) =>
      TrainingPlanTrainingDayModel(
        trainingPlanId: json['trainingPlan_id'],
        trainingDayId: json['trainingDay_id'],
      );

  Map<String, dynamic> toJson() => {
    'trainingPlan_id': trainingPlanId,
    'trainingDay_id': trainingDayId,
  };
}
