import 'package:bloc/bloc.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/data/repositories_impl/goal_repository_impl.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:meta/meta.dart';

part 'goals_add_state.dart';

class GoalsAddCubit extends Cubit<GoalsAddState> {
  GoalsAddCubit() : super(GoalsAddInitial());

  final repo = GoalRepositoryImpl.instance;

  int? exerciseId;
  int? weight;
  int? reps;
  bool _isAdded = false;
  bool get isAdded => _isAdded;

  Future addGoal() async {
    if (exerciseId == null) {
      emit(Error(message: StringManager.noSelectedExercise));
      return;
    } else if (weight == null) {
      emit(Error(message: StringManager.noSelectedWeight));
      return;
    } else if (reps == null) {
      emit(Error(message: StringManager.noSelectedReps));
      return;
    }
    _isAdded = true;
    await repo.addGoal(
      goal: Goal(
        id: null,
        exerciseId: exerciseId!,
        weight: weight,
        reps: reps,
        isAchieved: false,
      ),
    );
    emit(AddedGoal());
  }
}
