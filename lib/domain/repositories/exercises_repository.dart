import 'package:fit_track/domain/entities/exercise.dart';

abstract class ExercisesRepository {
  List<Exercise> get exercises;

  Future<void> fetchAllExercises();
  Future<void> addExercise({required Exercise exercise});
  Future<void> deleteExercise({required int exerciseID});
  Future<void> updateExercise({required Exercise exercise});
}
