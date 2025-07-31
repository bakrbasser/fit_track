import 'package:fit_track/data/data_source/DAOs/training_day_dao.dart';
import 'package:fit_track/data/data_source/DAOs/training_plan_day_dao.dart';
import 'package:fit_track/data/models/training_day_model.dart';
import 'package:fit_track/data/models/training_plan_training_day_model.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/repositories/training_day_repository.dart';

class TrainingDayRepositoryImpl implements TrainingDayRepository {
  TrainingDayRepositoryImpl._priv();
  static TrainingDayRepositoryImpl instance = TrainingDayRepositoryImpl._priv();

  final TrainingDayDao _dayDAO = TrainingDayDao.instance;
  final TrainingPlanDayDao _dayPlanDAO = TrainingPlanDayDao.dao;

  List<TrainingDay> _trainingDays = [];

  List<TrainingDay> get trainingDays => _trainingDays;

  @override
  Future<int> addTrainingDay({required TrainingDay trainingDay}) async {
    final model = TrainingDayModel.fromEntity(trainingDay);
    int id = await _dayDAO.addTrainingDay(trainingDay: model);
    trainingDay.id = id;
    _trainingDays.add(trainingDay);
    return id;
  }

  @override
  Future<void> deleteTrainingDay({required int trainingDayID}) async {
    await _dayDAO.deleteTrainingDay(trainingDayID: trainingDayID);
    _trainingDays.removeWhere((element) => element.id == trainingDayID);
  }

  @override
  Future<void> fetchTrainingDays() async {
    final days = await _dayDAO.fetchTrainingDays();
    _trainingDays = List.generate(
      days.length,
      (index) => days[index].toEntity(),
    );
  }

  @override
  Future<void> updateTrainingDay({required TrainingDay trainingDay}) async {
    final day = TrainingDayModel.fromEntity(trainingDay);
    await _dayDAO.updateTrainingDay(trainingDay: day);
    final idx = _trainingDays.indexWhere(
      (element) => element.id == trainingDay.id,
    );
    _trainingDays[idx] = trainingDay;
  }

  Future removeAllTrainingDayExercise({required int trainingDayId}) async {
    _dayDAO.removeAllTrainingDayExercise(trainingDayId: trainingDayId);
  }

  @override
  Future<int> dayExercisesCount(int dayId) async {
    return await _dayDAO.dayExercisesCount(dayId);
  }

  @override
  Future<List<int>> fetchPlanTrainingDaysIds({
    required int trainingPlanID,
  }) async {
    return await _dayPlanDAO.fetchPlanTrainingDaysIds(
      trainingPlanID: trainingPlanID,
    );
  }

  @override
  Future linkDaysToPlan({
    required List<int> daysID,
    required int planId,
  }) async {
    for (var i = 0; i < daysID.length; i++) {
      final model = TrainingPlanTrainingDayModel(
        trainingPlanId: planId,
        trainingDayId: daysID[i],
      );
      await _dayPlanDAO.linkDayToPlan(model: model);
    }
  }

  Future removeAllPlanDayLinks({required int planId}) async {
    _dayPlanDAO.removeAllPlanDayLinks(planId);
  }
}
