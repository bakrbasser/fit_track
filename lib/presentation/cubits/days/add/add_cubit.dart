import 'package:bloc/bloc.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());

  final repo = TrainingDayRepositoryImpl();

  String _name = '';
  String? _description;
  set name(String name) => _name = name;
  set description(String description) => _description = description;

  bool _isAdded = false;
  bool get isAdded => _isAdded;

  Future addDay() async {
    if (_name.isEmpty) {
      emit(Error(message: StringManager.emptyNameField));
      return;
    } else {
      if (_name.length <= 3) {
        emit(Error(message: StringManager.shortExerciseName));
        return;
      }
    }

    await repo.addTrainingDay(
      trainingDay: TrainingDay(id: 0, name: _name, description: _description),
    );
    final TrainingDay newDay = repo.trainingDays.last;
    _isAdded = true;

    emit(AddedDay(day: newDay));
  }
}
