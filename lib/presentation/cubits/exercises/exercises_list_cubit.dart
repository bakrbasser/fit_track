import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:meta/meta.dart';

part 'exercises_list_state.dart';

class ExercisesCubit extends Cubit<ExercisesListState> {
  ExercisesCubit() : super(ExercisesInitial());
  final exercisesRepo = ExercisesRepositoryImpl();

  Future fetchAllExercises() async {
    emit(ExercisesLoading());
    await exercisesRepo.fetchAllExercises();
    emit(ExercisesLoaded());
  }

  void loadList() {
    final exercises = exercisesRepo.exercises;
    if (exercises.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList(exercises: exercises));
    }
  }

  void addExercise({required Exercise? exercise}) {
    if (exercise != null) {
      final exercises = exercisesRepo.exercises;
      exercises.add(exercise);
      emit(FullList(exercises: exercises));
    }
  }
}
