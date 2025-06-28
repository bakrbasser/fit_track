import '../../domain/entities/exercise_log.dart';

class ExerciseLogModel {
  final int exerciseId;
  final String date;
  final int weight;
  final int sets;

  ExerciseLogModel({
    required this.exerciseId,
    required this.date,
    required this.weight,
    required this.sets,
  });

  factory ExerciseLogModel.fromJson(Map<String, dynamic> json) => ExerciseLogModel(
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

  factory ExerciseLogModel.fromEntity(ExerciseLog entity) => ExerciseLogModel(
        exerciseId: entity.exerciseId,
        date: entity.date,
        weight: entity.weight,
        sets: entity.sets,
      );

  ExerciseLog toEntity() => ExerciseLog(
        exerciseId: exerciseId,
        date: date,
        weight: weight,
        sets: sets,
      );
}