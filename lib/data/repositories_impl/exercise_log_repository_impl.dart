import 'package:fit_track/data/data_source/DAOs/exercise_log_dao.dart';
import 'package:fit_track/data/models/exercise_log_model.dart';
import 'package:fit_track/domain/entities/exercise_log.dart';
import 'package:fit_track/domain/repositories/exercise_log_repository.dart';

class ExerciseLogRepositoryImpl implements ExerciseLogRepository {
  final _dao = ExerciseLogDao.instance;
  @override
  Future<void> addExerciseLog({required ExerciseLog exerciseLog}) async {
    final model = ExerciseLogModel.fromEntity(exerciseLog);
    await _dao.addExerciseLog(exerciseLog: model);
  }

  @override
  Future<List<ExerciseLog>> fetchLogsByExerciseId(int exerciseId) async {
    final logs = await _dao.fetchLogsByExerciseId(exerciseId);
    return List.generate(logs.length, (index) => logs[index].toEntity());
  }
}
