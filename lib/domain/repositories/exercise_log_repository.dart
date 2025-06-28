import 'package:fit_track/domain/entities/exercise_log.dart';

abstract class ExerciseLogRepository {
  // Fetch all exercise logs (optionally filtered by date or exercise)
  Future<List<ExerciseLog>> fetchExerciseLogs();

  // Fetch a specific exercise log by its ID
  Future<ExerciseLog?> fetchExerciseExerciseId(int exerciseId);

  // Add a new exercise log
  Future<void> addExerciseLog({required ExerciseLog exerciseLog});

  // Update an existing exercise log
  Future<void> updateExerciseLog({required ExerciseLog exerciseLog});

  // Delete an exercise log
  Future<void> deleteExerciseLog({required int logId});
}
