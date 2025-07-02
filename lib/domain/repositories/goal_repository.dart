import 'package:fit_track/domain/entities/goal.dart';

abstract class GoalRepository {
  Future<List<Goal>> fetchGoals();
  Future addGoal({required Goal goal});
  Future deleteGoal({required int goalId});
  Future updateGoal({required Goal goal});
}
