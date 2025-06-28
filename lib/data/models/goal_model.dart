import '../../domain/entities/goal.dart';

class GoalModel extends Goal {
  GoalModel({
    required super.id,
    required super.exerciseId,
    super.weight,
    super.reps,
    super.isAchieved,
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
}
