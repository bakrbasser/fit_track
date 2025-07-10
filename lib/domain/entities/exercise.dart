class Exercise {
  final int? id;
  final String name;
  final String? instructions;

  @override
  String toString() {
    return name;
  }

  Exercise({required this.id, required this.name, this.instructions});
}

class DetailedExercise {
  final int exerciseID;
  final int sets;
  final int reps;

  DetailedExercise({
    required this.exerciseID,
    required this.sets,
    required this.reps,
  });
}
