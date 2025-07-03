import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:meta/meta.dart';

part 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  ExercisesCubit() : super(ExercisesInitial());
  final exercisesRepo = ExercisesRepositoryImpl();

  void addExercise() {}
}
