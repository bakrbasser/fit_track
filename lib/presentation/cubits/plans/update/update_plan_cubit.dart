import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_plan_repository_impl.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:meta/meta.dart';

part 'update_plan_state.dart';

class UpdatePlanCubit extends Cubit<UpdatePlanState> {
  UpdatePlanCubit({required this.plan}) : super(UpdatePlanInitial());

  final repo = TrainingPlanRepositoryImpl();
  final TrainingPlan plan;

  String _name = '';
  String? _description = '';
  String? _icon = '';

  set name(String name) => _name = name;
  set description(String description) => _description = description;
  set icon(String icon) => _icon = icon;

  bool _isUpdated = false;
  bool get isUpdated => _isUpdated;

  Future update() async {
    _isUpdated = true;

    if (_name.isEmpty) {
      _name = plan.name;
    }
    if (_description!.isEmpty) {
      _description = plan.description;
    }
    if (_icon!.isEmpty) {
      _icon = plan.icon;
    }

    final updatedPlan = TrainingPlan(
      id: plan.id,
      name: _name,
      description: _description,
      icon: _icon,
      isActivated: plan.isActivated,
    );

    await repo.updateTrainingPlan(trainingPlan: updatedPlan);
  }
}
