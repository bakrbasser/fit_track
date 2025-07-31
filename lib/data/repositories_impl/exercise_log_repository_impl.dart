import 'package:fit_track/data/data_source/DAOs/exercise_log_dao.dart';
import 'package:fit_track/data/models/exercise_log_model.dart';
import 'package:fit_track/domain/entities/exercise_log.dart';
import 'package:fit_track/domain/repositories/exercise_log_repository.dart';

class ExerciseLogRepositoryImpl implements ExerciseLogRepository {
  ExerciseLogRepositoryImpl._priv();
  static ExerciseLogRepositoryImpl instance = ExerciseLogRepositoryImpl._priv();
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

  @override
  Future<List<double>> fetchVolumeByDate(DateTime date) async {
    final logs = await _dao.fetchLogsByDate(date);
    List<double> volumes = List.filled(7, 0);
    if (logs.isNotEmpty) {
      int i = 0;
      DateTime logDate = DateTime.parse(logs[i].date);
      for (int j = 0; j < 7; j++) {
        if (date.day == logDate.day) {
          volumes[j] = logs[i].volume.toDouble();
          i++;
          if (i == logs.length) {
            break;
          }
          logDate = DateTime.parse(logs[i].date);
        }
        date = date.add(Duration(days: 1));
      }
    }
    return volumes;
  }
}
