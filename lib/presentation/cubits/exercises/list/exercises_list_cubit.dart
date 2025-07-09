import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:meta/meta.dart';

part 'exercises_list_state.dart';

class ExercisesListCubit extends Cubit<ExercisesListState> {
  ExercisesListCubit() : super(ExercisesInitial());
  final exercisesRepo = ExercisesRepositoryImpl.instance;

  List<Exercise> get exercises => exercisesRepo.exercises;

  void loadList() {
    emit(Loading());

    final exercises = exercisesRepo.exercises;
    if (exercises.isEmpty) {
      emit(EmptyList());
    } else {
      emit(FullList());
    }
  }

  Exercise exerciseById(int id) =>
      exercisesRepo.exercises.singleWhere((element) => element.id == id);
}
