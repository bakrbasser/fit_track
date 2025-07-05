import '../../domain/entities/goal.dart';

class GoalModel {
  final int id;
  final int exerciseId;
  final int? weight;
  final int? reps;
  final bool isAchieved;

  GoalModel({
    required this.id,
    required this.exerciseId,
    this.weight,
    this.reps,
    this.isAchieved = false,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    id: json['id'],
    exerciseId: json['exercise_id'],
    weight: json['weight'],
    reps: json['reps'],
    isAchieved: json['isAchieved'] == 1,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'exercise_id': exerciseId,
    'weight': weight,
    'reps': reps,
    'isAchieved': isAchieved ? 1 : 0,
  };

  factory GoalModel.fromEntity(Goal entity) => GoalModel(
    id: entity.id,
    exerciseId: entity.exerciseId,
    weight: entity.weight,
    reps: entity.reps,
    isAchieved: entity.isAchieved,
  );

  Goal toEntity() => Goal(
    id: id,
    exerciseId: exerciseId,
    weight: weight,
    reps: reps,
    isAchieved: isAchieved,
  );
}
