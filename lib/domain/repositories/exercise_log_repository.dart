import 'package:fit_track/data/models/exercise_log_model.dart';
import 'package:fit_track/domain/entities/exercise_log.dart';

abstract class ExerciseLogRepository {
  // Fetch a specific exercise log by its ID
  Future<List<ExerciseLog>> fetchLogsByExerciseId(int exerciseId);

  // Add a new exercise log
  Future<void> addExerciseLog({required ExerciseLogModel exerciseLog});

  // Update an existing exercise log
  Future<void> updateExerciseLog({required ExerciseLogModel exerciseLog});
}
