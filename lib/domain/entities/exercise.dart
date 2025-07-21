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
