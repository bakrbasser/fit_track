import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/training_plan_repository_impl.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:meta/meta.dart';

part 'today_workout_state.dart';

class TodayWorkoutCubit extends Cubit<TodayWorkoutState> {
  TodayWorkoutCubit() : super(TodayWorkoutInitial());

  final planRepo = TrainingPlanRepositoryImpl.instance;
  final dayRepo = TrainingDayRepositoryImpl.instance;

  Future<void> fetchTodayWorkout() async {
    final plan = planRepo.activePlan;
    if (plan == null) {
      emit(NoActivePlan());
    } else {
      final dayId = await planRepo.getPlanNextWorkout(plan.id!);
      final day = dayRepo.trainingDays.firstWhere(
        (element) => element.id! == dayId,
      );
      final dayCount = await dayRepo.dayExercisesCount(dayId!);
      emit(FetchedTodayWorkout(trainingDay: day, trainingsCount: dayCount));
    }
  }
}
