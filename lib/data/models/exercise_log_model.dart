import 'package:fit_track/domain/entities/exercise_log.dart';

class ExerciseLogModel {
  final int? exerciseId;
  final String date;
  final int volume;
  final int maxWeight;

  ExerciseLogModel({
    required this.exerciseId,
    required this.date,
    required this.volume,
    required this.maxWeight,
  });

  factory ExerciseLogModel.fromJson(Map<String, dynamic> json) =>
      ExerciseLogModel(
        exerciseId: json['exercise_id'],
        date: json['date'],
        volume: json['volume'],
        maxWeight: json['maxWeight'],
      );

  Map<String, dynamic> toJson() => {
    'exercise_id': exerciseId,
    'date': date,
    'volume': volume,
    'maxWeight': maxWeight,
  };

  factory ExerciseLogModel.fromEntity(ExerciseLog entity) => ExerciseLogModel(
    exerciseId: entity.exerciseId,
    date: entity.date,
    volume: entity.volume,
    maxWeight: entity.maxWeight,
  );

  ExerciseLog toEntity() => ExerciseLog(
    exerciseId: exerciseId,
    date: date,
    volume: volume,
    maxWeight: maxWeight,
  );
}
