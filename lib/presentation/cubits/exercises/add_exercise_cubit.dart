import 'package:bloc/bloc.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/exercises/add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit() : super(AddExerciseInitial());
  final exercisesRepo = ExercisesRepositoryImpl();

  String? _name;
  String? _instructions;

  set name(String name) => _name = name;
  set instructions(String instructions) => _instructions = instructions;

  Future addExercise() async {
    if (_name == null) {
      emit(Error(message: StringManager.emptyExerciseNameField));
      return;
    } else {
      if (_name!.length <= 3) {
      emit(Error(message: StringManager.shortExerciseName));
      return;
      }
    }
    final Exercise newExercise = Exercise(id: 0, name: name)

  }
}
