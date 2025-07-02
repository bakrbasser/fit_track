import 'package:fit_track/data/data_source/DAOs/goal_dao.dart';
import 'package:fit_track/data/models/goal_model.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:fit_track/domain/repositories/goal_repository.dart';

class GoalRepositoryImpl implements GoalRepository {
  final _dao = GoalDao.instance;
  @override
  Future addGoal({required Goal goal}) async {
    final model = GoalModel.fromEntity(goal);
    await _dao.addGoal(goal: model);
  }

  @override
  Future deleteGoal({required int goalId}) async {
    _dao.deleteGoal(goalId: goalId);
  }

  @override
  Future<List<Goal>> fetchGoals() async {
    final goals = await _dao.fetchGoals();
    return List.generate(goals.length, (index) => goals[index].toEntity());
  }

  @override
  Future updateGoal({required Goal goal}) async {
    final model = GoalModel.fromEntity(goal);
    await _dao.updateGoal(goal: model);
  }
}
