import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/goal_repository_impl.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:meta/meta.dart';

part 'goals_list_state.dart';

class GoalsListCubit extends Cubit<GoalsListState> {
  GoalsListCubit() : super(GoalsListInitial());
  final repo = GoalRepositoryImpl.instance;

  void loadList() {
    emit(Loading());

    final goals = repo.goals;
    if (goals.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList(goals: goals));
    }
  }
}
