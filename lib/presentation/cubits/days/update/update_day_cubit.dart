import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/training_day_exercise_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/training_day_repository_impl.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/entities/training_day_exercise.dart';
import 'package:meta/meta.dart';

part 'update_day_state.dart';

class UpdateDayCubit extends Cubit<UpdateDayState> {
  UpdateDayCubit({required this.day}) : super(UpdateDayInitial());

  final repo = TrainingDayRepositoryImpl.instance;
  final connectRepo = TrainingDayExerciseRepositoryImpl.instance;

  final TrainingDay day;

  String _name = '';
  String? _description = '';
  set name(String name) => _name = name;
  set description(String description) => _description = description;

  bool _isUpdated = false;
  bool get isUpdated => _isUpdated;

  Set<TrainingDayExercise> exercises = {};

  Future initialize() async {
    var dayExer = await connectRepo.fetchTrainingDayExercises(dayId: day.id!);
    for (var element in dayExer) {
      exercises.add(element);
    }
  }

  void selectExercise(int dayId, bool value, int exId, int sets, int reps) {
    if (value) {
      exercises.add(
        TrainingDayExercise(
          trainingDayId: dayId,
          exerciseId: exId,
          sets: sets,
          reps: reps,
        ),
      );
    } else {
      exercises.removeWhere((element) => exId == element.exerciseId);
    }
  }

  Future<void> connectExercisesToDay() async {
    final list = exercises.toList();
    for (var i = 0; i < exercises.length; i++) {
      list[i].trainingDayId = day.id;
      await connectRepo.addTrainingDayExercise(trainingDayExercise: list[i]);
    }
  }

  void updateReps(int exerciseId, int newReps) {
    exercises.firstWhere((element) => element.exerciseId == exerciseId).reps =
        newReps;
  }

  void updateSets(int exerciseId, int newSets) {
    exercises.firstWhere((element) => element.exerciseId == exerciseId).sets =
        newSets;
  }

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

    await repo.removeAllTrainingDayExercise(trainingDayId: day.id!);
    await connectExercisesToDay();
    await repo.updateTrainingDay(trainingDay: updatedDay);
  }
}
