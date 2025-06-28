import 'package:fit_track/domain/entities/exercise.dart';

abstract class ExercisesRepository {
  Future fetchAllExercises();
  Future addExercise({required Exercise exercise});
  Future deleteExercise({required int exerciseID});
  Future updateExercise({required Exercise exercise});
}
