import '../../domain/entities/training_plan.dart';

class TrainingPlanModel {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final bool isActivated;

  TrainingPlanModel({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.isActivated = false,
  });

  factory TrainingPlanModel.fromJson(Map<String, dynamic> json) => TrainingPlanModel(
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

  factory TrainingPlanModel.fromEntity(TrainingPlan entity) => TrainingPlanModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        icon: entity.icon,
        isActivated: entity.isActivated,
      );

  TrainingPlan toEntity() => TrainingPlan(
        id: id,
        name: name,
        description: description,
        icon: icon,
        isActivated: isActivated,
      );
}