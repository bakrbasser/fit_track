import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_plan_repository_impl.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:meta/meta.dart';

part 'plans_list_state.dart';

class PlansListCubit extends Cubit<PlansListState> {
  PlansListCubit() : super(PlansListInitial());

  final repo = TrainingPlanRepositoryImpl.instance;

  void loadList() {
    emit(Loading());

    final plans = repo.trainingPlans;
    if (plans.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList(plans: plans));
    }
  }

  Future<void> activatePlan({required TrainingPlan plan}) async {
    await repo.activatePlan(plan: plan);
    loadList();
  }

  Future<void> deactivatePlan() async {
    await repo.deactivatePlan();
    loadList();
  }
}
