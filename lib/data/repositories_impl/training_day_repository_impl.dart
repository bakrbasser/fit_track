import 'package:fit_track/data/data_source/DAOs/training_day_dao.dart';
import 'package:fit_track/data/models/training_day_model.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/repositories/training_day_repository.dart';

class TrainingDayRepositoryImpl implements TrainingDayRepository {
  TrainingDayRepositoryImpl._priv();
  static TrainingDayRepositoryImpl instance = TrainingDayRepositoryImpl._priv();
  final TrainingDayDao _dao = TrainingDayDao.instance;

  List<TrainingDay> _trainingDays = [];

  List<TrainingDay> get trainingDays => _trainingDays;

  @override
  Future<int> addTrainingDay({required TrainingDay trainingDay}) async {
    final model = TrainingDayModel.fromEntity(trainingDay);
    int id = await _dao.addTrainingDay(trainingDay: model);
    trainingDay.id = id;
    _trainingDays.add(trainingDay);
    return id;
  }

  @override
  Future<void> deleteTrainingDay({required int trainingDayID}) async {
    await _dao.deleteTrainingDay(trainingDayID: trainingDayID);
    _trainingDays.removeWhere((element) => element.id == trainingDayID);
  }

  @override
  Future<void> fetchTrainingDays() async {
    final days = await _dao.fetchTrainingDays();
    _trainingDays = List.generate(
      days.length,
      (index) => days[index].toEntity(),
    );
  }

  @override
  Future<void> updateTrainingDay({required TrainingDay trainingDay}) async {
    final day = TrainingDayModel.fromEntity(trainingDay);
    await _dao.updateTrainingDay(trainingDay: day);
    final idx = _trainingDays.indexWhere(
      (element) => element.id == trainingDay.id,
    );
    _trainingDays[idx] = trainingDay;
  }

  @override
  Future<int> dayExercisesCount(int dayId) async {
    return await _dao.dayExercisesCount(dayId);
  }
}
