import 'package:fit_track/domain/entities/goal.dart';

abstract class GoalRepository {
  Future fetchGoals();
<<<<<<< HEAD
  Future addGoal({required Goal goal});
  Future deleteGoal({required int goalId});
  Future updateGoal({required Goal goal});
=======
  Future fetchAchievedGoals();
  Future fetchUnAchievedGoals();
  Future addGoal({required Goal goal});
  Future deleteGoal({required int goalId});
  Future updateGoal({required int goalId});
  Future achieveGoal({required int goalId});
>>>>>>> bd3f4bee7b2cf845a71eadb0c8a9461bd87e86d5
}
