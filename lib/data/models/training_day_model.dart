import '../../domain/entities/training_day.dart';

class TrainingDayModel extends TrainingDay {
  TrainingDayModel({required super.id, required super.name, super.description});

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
}
