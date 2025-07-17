import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:meta/meta.dart';

part 'days_list_state.dart';

class DaysListCubit extends Cubit<DaysListState> {
  DaysListCubit() : super(DaysListInitial());
  final repo = TrainingDayRepositoryImpl.instance;

  loadList() {
    emit(Loading());
    final days = repo.trainingDays;

    if (days.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList(days: days));
    }
  }

  Future<int> dayExercisesCount(int dayId) async {
    return await repo.dayExercisesCount(dayId);
  }
}
