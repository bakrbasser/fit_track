import 'package:fit_track/domain/entities/exercise.dart';

abstract class ExercisesRepository {
<<<<<<< HEAD
  Future<List<Exercise>> fetchAllExercises();
  Future<void> addExercise({required Exercise exercise});
  Future<void> deleteExercise({required int exerciseID});
  Future<void> updateExercise({required Exercise exercise});
=======
  Future fetchAllExercises();
  Future addExercise({required Exercise exercise});
  Future deleteExercise({required int exerciseID});
  Future updateExercise({required Exercise exercise});
>>>>>>> bd3f4bee7b2cf845a71eadb0c8a9461bd87e86d5
}
