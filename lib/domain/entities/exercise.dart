class Exercise {
  final int id;
  final String name;
  final String? instructions;

  Exercise({required this.id, required this.name, this.instructions});
}

class DetailedExercise {
  final Exercise exercise;
  final int sets;
  final int reps;

  DetailedExercise({
    required this.exercise,
    required this.sets,
    required this.reps,
  });
}
