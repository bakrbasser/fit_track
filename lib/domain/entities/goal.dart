class Goal {
  final int id;
  final int exerciseId;
  final int? weight;
  final int? reps;
  final bool isAchieved;

  Goal({
    required this.id,
    required this.exerciseId,
    this.weight,
    this.reps,
    this.isAchieved = false,
  });
}
