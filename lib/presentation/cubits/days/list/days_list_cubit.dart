import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:meta/meta.dart';

part 'days_list_state.dart';

class DaysListCubit extends Cubit<DaysListState> {
  DaysListCubit() : super(DaysListInitial());
  final repo = TrainingDayRepositoryImpl.instance;

  Map<int, int> trainingDaysIds = {};
  int numberOfDays = 0;

  loadList() {
    emit(Loading());
    final days = repo.trainingDays;

    if (days.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList(days: days, counts: []));
    }
  }

  void loadPlanDays(int trainingPlanID) async {
    emit(Loading());
    final daysIds = await repo.fetchPlanTrainingDaysIds(
      trainingPlanID: trainingPlanID,
    );
    numberOfDays = daysIds.length;
    if (daysIds.isEmpty) {
      emit(EmptyList());
    } else {
      for (var i = 0; i < daysIds.length; i++) {
        trainingDaysIds[i] = daysIds[i];
      }
      var days =
          daysIds
              .map(
                (id) =>
                    repo.trainingDays.firstWhere((element) => element.id == id),
              )
              .toList();
      List<int> counts = [];
      for (var element in daysIds) {
        counts.add(await repo.dayExercisesCount(element));
      }
      emit(FullList(days: days, counts: counts));
    }
  }

  Future<int> dayExercisesCount(int dayId) async {
    return await repo.dayExercisesCount(dayId);
  }

  void addDayToList({required int index, required int dayID}) {
    trainingDaysIds[index] = dayID;
  }

  bool checkFullDays() => numberOfDays == trainingDaysIds.length;

  bool assignDayToPlan(TrainingDay? day, int index) {
    if (day != null) {
      if (trainingDaysIds.values.contains(day.id)) {
        return false;
      }
      trainingDaysIds[index] = day.id!;
      return true;
    }
    return false;
  }

  void removeDayFromNewPlan(int index) {
    if (trainingDaysIds.containsKey(index)) {
      trainingDaysIds.remove(index);
    }
  }

  void removeDayFromNewExistingPlan(int index) {
    if (trainingDaysIds.containsKey(index)) {
      trainingDaysIds.remove(index);
    }
  }

  Future<void> updatePlanDays({required int planId}) async {
    await repo.removeAllPlanDayLinks(planId: planId);
    await addPlanDays(planId);
  }

  Future<void> addPlanDays(int planId) async {
    await repo.linkDaysToPlan(
      daysID: trainingDaysIds.values.toList(),
      planId: planId,
    );
  }

  Future removeLinkDayToPlan({required int planId}) async {
    repo.removeAllPlanDayLinks(planId: planId);
  }
}
