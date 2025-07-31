import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/goal_repository_impl.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:meta/meta.dart';

part 'goals_list_state.dart';

class GoalsListCubit extends Cubit<GoalsListState> {
  GoalsListCubit() : super(GoalsListInitial());
  final repo = GoalRepositoryImpl.instance;
  List<Goal> _unAchievedGoals = [];
  List<Goal> _achievedGoals = [];

  List<Goal> get unAchievedGoals => _unAchievedGoals;
  List<Goal> get achievedGoals => _achievedGoals;

  void loadUnAchievedList() {
    emit(Loading());
    _unAchievedGoals =
        repo.goals.where((element) => !element.isAchieved).toList();
    if (_unAchievedGoals.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList(goals: _unAchievedGoals));
    }
  }

  void loadAchievedList() {
    emit(Loading());
    _achievedGoals = repo.goals.where((element) => element.isAchieved).toList();
    if (_achievedGoals.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList(goals: _achievedGoals));
    }
  }

  void deleteGoal(Goal goal) {
    repo.deleteGoal(goalId: goal.id!);
  }
}
