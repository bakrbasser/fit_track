import 'package:fit_track/domain/entities/training_day.dart';

abstract class TrainingDayRepository {
  Future<void> fetchTrainingDays();
  Future<void> updateTrainingDay({required TrainingDay trainingDay});
  Future<void> deleteTrainingDay({required int trainingDayID});
  Future<void> addTrainingDay({required TrainingDay trainingDay});
  Future<List<int>> fetchPlanTrainingDaysIds({required int trainingPlanID});
  Future linkDaysToPlan({required List<int> daysID, required int planId});
  Future<int> dayExercisesCount(int dayId);
}
