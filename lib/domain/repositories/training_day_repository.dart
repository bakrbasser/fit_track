import 'package:fit_track/domain/entities/training_day.dart';

abstract class TrainingDayRepository {
  Future<List<TrainingDay>> fetchTrainingDays();
  Future<void> updateTrainingDay({required TrainingDay trainingDay});
  Future<void> deleteTrainingDay({required int trainingDayID});
  Future<void> addTrainingDay({required TrainingDay trainingDay});
}
