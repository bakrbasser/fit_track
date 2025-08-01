import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/exercise_log_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise_log.dart';
import 'package:meta/meta.dart';

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  ChartsCubit() : super(ChartsInitial());
  ExerciseLogRepositoryImpl repo = ExerciseLogRepositoryImpl.instance;

  late List<ExerciseLog> _exerciseLogs;

  Future<void> weeklyProgress() async {
    emit(ChartLoading());
    final date = DateTime.now().subtract(Duration(days: 6));
    final volumes = await repo.fetchVolumeByDate(date);

    final totalVolume = volumes.fold(
      0.0,
      (previousValue, element) => previousValue + element,
    );
    emit(
      ChartReady(
        data: volumes,
        title: 'Total Volume',
        subTitle: '$totalVolume kgs',
      ),
    );
  }

  Future<void> initExerciseCharts({required int exerciseId}) async {
    emit(ChartLoading());
    _exerciseLogs = await repo.fetchLogsByExerciseId(exerciseId);
    emit(ChartFinishedLoading());
  }

  void exerciseVolumeChart() {
    double totalVolume = 0;
    final volumes = List.generate(_exerciseLogs.length, (index) {
      totalVolume += _exerciseLogs[index].volume;
      return _exerciseLogs[index].volume.toDouble();
    });
    emit(
      ChartReady(
        data: volumes,
        title: 'Total Volume',
        subTitle: '$totalVolume kgs',
      ),
    );
  }

  void exerciseMaxWeightChart() {
    int maxWeight = 0;
    final maxWeights = List.generate(_exerciseLogs.length, (index) {
      if (_exerciseLogs[index].maxWeight > maxWeight) {
        maxWeight = _exerciseLogs[index].maxWeight;
      }
      return _exerciseLogs[index].maxWeight.toDouble();
    });
    emit(
      ChartReady(
        data: maxWeights,
        title: 'Total Volume',
        subTitle: 'PR is $maxWeight kg',
      ),
    );
  }
}
