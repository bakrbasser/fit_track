import 'package:bloc/bloc.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/data/repositories_impl/training_day_exercise_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/entities/training_day_exercise.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

class AddDayCubit extends Cubit<AddDayState> {
  AddDayCubit() : super(AddInitial());

  final dayRepo = TrainingDayRepositoryImpl.instance;
  final connectRepo = TrainingDayExerciseRepositoryImpl.instance;

  late int id;
  String name = '';
  String? description;
  List<TrainingDayExercise> exercises = [];

  bool _isAdded = false;
  bool get isAdded => _isAdded;

  void selectExercise(bool value, int exId, int sets, int reps) {
    if (value) {
      exercises.add(
        TrainingDayExercise(
          trainingDayId: null,
          exerciseId: exId,
          sets: sets,
          reps: reps,
        ),
      );
    } else {
      exercises.removeWhere((element) => exId == element.exerciseId);
    }
  }

  Future addDay() async {
    if (name.isEmpty) {
      emit(Error(message: StringManager.emptyNameField));
      return;
    } else {
      if (name.length <= 3) {
        emit(Error(message: StringManager.shortNameField));
        return;
      }
    }

    id = await dayRepo.addTrainingDay(
      trainingDay: TrainingDay(id: null, name: name, description: description),
    );
    final TrainingDay newDay = dayRepo.trainingDays.last;
    await connectExercisesToDay(id);
    _isAdded = true;

    emit(AddedDay(day: newDay));
  }

  Future<void> connectExercisesToDay(int dayId) async {
    for (var i = 0; i < exercises.length; i++) {
      exercises[i].trainingDayId = dayId;
      await connectRepo.addTrainingDayExercise(
        trainingDayExercise: exercises[i],
      );
    }
  }
}
