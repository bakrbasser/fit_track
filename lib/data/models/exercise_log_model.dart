import '../../domain/entities/exercise_log.dart';

class ExerciseLogModel extends ExerciseLog {
  ExerciseLogModel({
    required super.exerciseId,
    required super.date,
    required super.weight,
    required super.sets,
  });

  factory ExerciseLogModel.fromJson(Map<String, dynamic> json) =>
      ExerciseLogModel(
        exerciseId: json['exercise_id'],
        date: json['date'],
        weight: json['weight'],
        sets: json['sets'],
      );

  Map<String, dynamic> toJson() => {
    'exercise_id': exerciseId,
    'date': date,
    'weight': weight,
    'sets': sets,
  };
}
