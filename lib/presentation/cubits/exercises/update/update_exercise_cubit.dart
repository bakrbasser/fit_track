import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/exercises/update/update_exercise_state.dart';

class UpdateExerciseCubit extends Cubit<UpdateExerciseState> {
  UpdateExerciseCubit({required this.exercise})
    : super(UpdateExerciseInitial());

  final exercisesRepo = ExercisesRepositoryImpl.instance;
  final Exercise exercise;
  String _name = '';
  String? _instructions;

  bool _isUpdated = false;
  bool get isUpdated => _isUpdated;

  set name(String name) => _name = name;
  set instructions(String instructions) => _instructions = instructions;

  Future update() async {
    _isUpdated = true;
    if (_name.isEmpty) {
      _name = exercise.name;
    }
    if (_instructions == null) {
      _instructions = exercise.instructions;
    } else if (_instructions!.isEmpty) {
      _instructions = exercise.instructions;
    }

    final updatedExercise = Exercise(
      id: exercise.id,
      name: _name,
      instructions: _instructions,
    );
    exercisesRepo.updateExercise(exercise: updatedExercise);
  }
}
