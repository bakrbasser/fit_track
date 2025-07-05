import '../../domain/entities/training_plan_training_day.dart';

class TrainingPlanTrainingDayModel {
  final int trainingPlanId;
  final int trainingDayId;

  TrainingPlanTrainingDayModel({
    required this.trainingPlanId,
    required this.trainingDayId,
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

  factory TrainingPlanTrainingDayModel.fromEntity(
    TrainingPlanTrainingDay entity,
  ) => TrainingPlanTrainingDayModel(
    trainingPlanId: entity.trainingPlanId,
    trainingDayId: entity.trainingDayId,
  );

  TrainingPlanTrainingDay toEntity() => TrainingPlanTrainingDay(
    trainingPlanId: trainingPlanId,
    trainingDayId: trainingDayId,
  );
}
