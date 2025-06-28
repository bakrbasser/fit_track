import 'package:fit_track/domain/entities/training_day.dart';

abstract class TrainingDayRepository {
  Future fetchTrainingDays();
  Future updateTrainingDay({required int trainingDayID});
  Future deleteTrainingDay({required int trainingDayID});
  Future addTrainingDay({required TrainingDay trainingDay});
}
