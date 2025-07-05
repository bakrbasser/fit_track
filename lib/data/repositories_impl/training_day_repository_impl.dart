import 'package:fit_track/data/data_source/DAOs/training_day_dao.dart';
import 'package:fit_track/data/models/training_day_exercise_model.dart';
import 'package:fit_track/data/models/training_day_model.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/entities/training_day_exercise.dart';
import 'package:fit_track/domain/repositories/training_day_repository.dart';

class TrainingDayRepositoryImpl implements TrainingDayRepository {
  final TrainingDayDao _dao = TrainingDayDao.instance;

  List<TrainingDay> _trainingDays = [];

  List<TrainingDay> get trainingDays => _trainingDays;

  @override
  Future<void> addTrainingDay({required TrainingDay trainingDay}) async {
    final model = TrainingDayModel.fromEntity(trainingDay);
    await _dao.addTrainingDay(trainingDay: model);
    _trainingDays.add(trainingDay);
  }

  @override
  Future<void> deleteTrainingDay({required int trainingDayID}) async {
    await _dao.deleteTrainingDay(trainingDayID: trainingDayID);
    _trainingDays.removeWhere((element) => element.id == trainingDayID);
  }

  @override
  Future<List<DetailedExercise>> fetchTrainingDayExercises({
    required int trainingDayID,
  }) async {
    final exercises = await _dao.fetchTrainingDayExercises(
      trainingDayID: trainingDayID,
    );
    return List.generate(
      exercises.length,
      (index) => exercises[index].toEntity(),
    );
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
  Future addTrainingDayExercises({
    required TrainingDayExercise trainingDayExercise,
  }) async {
    final tDEM = TrainingDayExerciseModel.fromEntity(trainingDayExercise);
    await _dao.addTrainingDayExercises(trainingDayExercise: tDEM);
  }

  @override
  Future removeTrainingDayExercises({
    required TrainingDayExercise trainingDayExercise,
  }) async {
    final tDEM = TrainingDayExerciseModel.fromEntity(trainingDayExercise);
    await _dao.removeTrainingDayExercises(trainingDayExercise: tDEM);
  }
}
