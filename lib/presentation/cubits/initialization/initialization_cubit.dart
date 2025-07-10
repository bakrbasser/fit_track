import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/goal_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/training_plan_repository_impl.dart';
import 'package:meta/meta.dart';

part 'initialization_state.dart';

class InitializationCubit extends Cubit<InitializationState> {
  InitializationCubit() : super(InitializationInitial());

  final planRepo = TrainingPlanRepositoryImpl.instance;
  final dayRepo = TrainingDayRepositoryImpl();
  final exerciseRepo = ExercisesRepositoryImpl.instance;
  final goalRepo = GoalRepositoryImpl.instance;

  Future<void> initialize() async {
    emit(Initializing());
    await planRepo.fetchTrainingPlans();
    await dayRepo.fetchTrainingDays();
    await exerciseRepo.fetchAllExercises();
    await goalRepo.fetchGoals();

    emit(Initialized());
  }
}
