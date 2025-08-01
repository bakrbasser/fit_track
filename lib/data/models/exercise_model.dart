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
