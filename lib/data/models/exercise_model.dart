import '../../domain/entities/exercise.dart';

class ExerciseModel {
  final int? id;
  final String name;
  final String? instructions;

  ExerciseModel({required this.id, required this.name, this.instructions});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
    id: json['id'],
    name: json['name'],
    instructions: json['instructions'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'instructions': instructions,
  };

  factory ExerciseModel.fromEntity(Exercise entity) => ExerciseModel(
    id: entity.id,
    name: entity.name,
    instructions: entity.instructions,
  );

  Exercise toEntity() =>
      Exercise(id: id, name: name, instructions: instructions);
}

class DetailedExerciseModel {
  final int exerciseID;
  final int sets;
  final int reps;

  DetailedExerciseModel({
    required this.exerciseID,
    required this.sets,
    required this.reps,
  });

  // Convert to JSON (for API/local storage)
  Map<String, dynamic> toJson() => {
    'exercise_id': exerciseID, // Assumes Exercise has toJson()
    'sets': sets,
    'reps': reps,
  };

  // Parse from JSON (factory constructor)
  factory DetailedExerciseModel.fromJson(Map<String, dynamic> json) {
    return DetailedExerciseModel(
      exerciseID: json['exercise_id'] as int,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
    );
  }

  // Convert to Entity (for domain layer)
  DetailedExercise toEntity() =>
      DetailedExercise(exerciseID: exerciseID, sets: sets, reps: reps);

  // Create from Entity (factory constructor)
  factory DetailedExerciseModel.fromEntity(DetailedExercise entity) {
    return DetailedExerciseModel(
      exerciseID: entity.exerciseID,
      sets: entity.sets,
      reps: entity.reps,
    );
  }
}
