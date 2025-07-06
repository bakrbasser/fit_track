import 'package:bloc/bloc.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/data/repositories_impl/training_plan_repository_impl.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:meta/meta.dart';

part 'add_plan_state.dart';

class AddPlanCubit extends Cubit<AddPlanState> {
  AddPlanCubit() : super(AddPlanInitial());

  final repo = TrainingPlanRepositoryImpl();

  String _name = '';
  String? _description;
  String? _icon;

  set name(String name) => _name = name;
  set description(String description) => _description = description;
  set icon(String icon) => _icon = icon;

  bool _isAdded = false;
  bool get isAdded => _isAdded;

  Future addPlan() async {
    if (_name.isEmpty) {
      emit(Error(message: StringManager.emptyNameField));
      return;
    } else {
      if (_name.length <= 3) {
        emit(Error(message: StringManager.shortExerciseName));
        return;
      }
    }

    await repo.addTrainingPlan(
      trainingPlan: TrainingPlan(
        id: 0,
        name: _name,
        description: _description,
        icon: _icon,
      ),
    );
    final TrainingPlan newPlan = repo.trainingPlans.last;
    _isAdded = true;

    emit(AddedPlan(plan: newPlan));
  }
}
