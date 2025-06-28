import '../../domain/entities/exercise.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({required super.id, required super.name, super.instructions});

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
}
