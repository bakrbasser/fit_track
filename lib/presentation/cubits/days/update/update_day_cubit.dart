import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:meta/meta.dart';

part 'update_day_state.dart';

class UpdateDayCubit extends Cubit<UpdateDayState> {
  UpdateDayCubit({required this.day}) : super(UpdateDayInitial());

  final repo = TrainingDayRepositoryImpl.instance;
  final TrainingDay day;

  String _name = '';
  String? _description = '';
  set name(String name) => _name = name;
  set description(String description) => _description = description;

  bool _isUpdated = false;
  bool get isUpdated => _isUpdated;

  Future update() async {
    _isUpdated = true;

    if (_name.isEmpty) {
      _name = day.name;
    }
    if (_description!.isEmpty) {
      _description = day.description;
    }

    final updatedDay = TrainingDay(
      id: day.id,
      name: _name,
      description: _description,
    );

    await repo.updateTrainingDay(trainingDay: updatedDay);
  }
}
