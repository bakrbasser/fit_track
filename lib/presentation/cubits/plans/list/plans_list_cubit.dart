import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_plan_repository_impl.dart';
import 'package:meta/meta.dart';

part 'plans_list_state.dart';

class PlansListCubit extends Cubit<PlansListState> {
  PlansListCubit() : super(PlansListInitial());

  final repo = TrainingPlanRepositoryImpl.instance;

  loadList() {
    emit(Loading());

    final plans = repo.trainingPlans;
    if (plans.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList());
    }
  }
}
