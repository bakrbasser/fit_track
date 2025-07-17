class TrainingPlan {
  final int? id;
  final String name;
  final String? description;
  final String? icon;
  bool isActivated;

  TrainingPlan({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.isActivated = false,
  });
}
