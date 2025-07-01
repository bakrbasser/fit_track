import 'package:fit_track/domain/entities/training_day.dart';

abstract class TrainingDayRepository {
<<<<<<< HEAD
  Future<List<TrainingDay>> fetchTrainingDays();
  Future<void> updateTrainingDay({required TrainingDay trainingDay});
  Future<void> deleteTrainingDay({required int trainingDayID});
  Future<void> addTrainingDay({required TrainingDay trainingDay});
=======
  Future fetchTrainingDays();
  Future updateTrainingDay({required int trainingDayID});
  Future deleteTrainingDay({required int trainingDayID});
  Future addTrainingDay({required TrainingDay trainingDay});
>>>>>>> bd3f4bee7b2cf845a71eadb0c8a9461bd87e86d5
}
