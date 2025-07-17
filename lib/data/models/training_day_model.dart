import '../../domain/entities/training_day.dart';

class TrainingDayModel {
  final int? id;
  final String name;
  final String? description;

  TrainingDayModel({required this.id, required this.name, this.description});

  factory TrainingDayModel.fromJson(Map<String, dynamic> json) =>
      TrainingDayModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };

  factory TrainingDayModel.fromEntity(TrainingDay entity) => TrainingDayModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
  );

  TrainingDay toEntity() =>
      TrainingDay(id: id, name: name, description: description);
}
