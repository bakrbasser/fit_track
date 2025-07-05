import 'package:fit_track/data/data_source/DAOs/goal_dao.dart';
import 'package:fit_track/data/models/goal_model.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:fit_track/domain/repositories/goal_repository.dart';

class GoalRepositoryImpl implements GoalRepository {
  final _dao = GoalDao.instance;

  List<Goal> _goals = [];
  List<Goal> get goals => _goals;

  @override
  Future addGoal({required Goal goal}) async {
    final model = GoalModel.fromEntity(goal);
    int id = await _dao.addGoal(goal: model);
    _goals.add(
      Goal(
        id: id,
        exerciseId: goal.exerciseId,
        isAchieved: goal.isAchieved,
        reps: goal.reps,
        weight: goal.weight,
      ),
    );
  }

  @override
  Future fetchGoals() async {
    final goals = await _dao.fetchGoals();
    _goals = List.generate(goals.length, (index) => goals[index].toEntity());
  }

  @override
  Future<void> updateGoal({required Goal goal}) async {
    final model = GoalModel.fromEntity(goal);
    await _dao.updateGoal(goal: model);

    final index = _goals.indexWhere((g) => g.id == goal.id);
    if (index != -1) {
      _goals[index] = goal;
    }
  }

  @override
  Future<void> deleteGoal({required int goalId}) async {
    await _dao.deleteGoal(goalId: goalId);
    _goals.removeWhere((goal) => goal.id == goalId);
  }
}
