import 'package:bloc/bloc.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/exercises/add/add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit() : super(AddExerciseInitial());
  final exercisesRepo = ExercisesRepositoryImpl();

  String? _name;
  String? _instructions;

  bool _isAdded = false;
  bool get isAdded => _isAdded;

  set name(String name) => _name = name;
  set instructions(String instructions) => _instructions = instructions;

  Future addExercise() async {
    if (_name == null) {
      emit(Error(message: StringManager.emptyNameField));
      return;
    } else {
      if (_name!.length <= 3) {
        emit(Error(message: StringManager.shortExerciseName));
        return;
      }
    }
    await exercisesRepo.addExercise(
      exercise: Exercise(id: null, name: _name!, instructions: _instructions),
    );
    final Exercise newExercise = exercisesRepo.exercises.last;
    _isAdded = true;

    emit(AddedExercise(exercise: newExercise));
  }
}
