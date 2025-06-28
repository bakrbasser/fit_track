import '../../domain/entities/training_plan.dart';

class TrainingPlanModel extends TrainingPlan {
  TrainingPlanModel({
    required super.id,
    required super.name,
    super.description,
    super.icon,
    super.isActivated,
  });

  factory TrainingPlanModel.fromJson(Map<String, dynamic> json) =>
      TrainingPlanModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        icon: json['icon'],
        isActivated: json['isActivated'] == 1,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'icon': icon,
    'isActivated': isActivated ? 1 : 0,
  };
}
