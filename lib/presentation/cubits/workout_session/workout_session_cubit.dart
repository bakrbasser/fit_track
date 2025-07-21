import 'package:bloc/bloc.dart';
import 'package:fit_track/data/repositories_impl/exercise_log_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/exercise_repository_impl.dart';
import 'package:fit_track/data/repositories_impl/training_day_exercise_repository_impl.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/domain/entities/exercise_log.dart';
import 'package:fit_track/domain/entities/training_day_exercise.dart';
import 'package:meta/meta.dart';

part 'workout_session_state.dart';

class WorkoutSessionCubit extends Cubit<WorkoutSessionState> {
  WorkoutSessionCubit(this.trainingDayId) : super(WorkoutSessionInitial());

  final int trainingDayId;

  int totalVolume = 0;

  int currentIndex = 0;

  TrainingDayExerciseRepositoryImpl repo =
      TrainingDayExerciseRepositoryImpl.instance;

  ExercisesRepositoryImpl exercisesRepo = ExercisesRepositoryImpl.instance;

  ExerciseLogRepositoryImpl exercisesLogRepo =
      ExerciseLogRepositoryImpl.instance;

  List<TrainingDayExercise> exercises = [];

  List<int> _weights = [];
  List<int> _reps = [];

  void _initLists(int index) {
    _weights = List.filled(exercises[index].sets, 0);
    _reps = List.filled(exercises[index].sets, exercises[index].reps);
  }

  Future<void> loadExercises() async {
    emit(WorkoutsLoading());
    exercises = await repo.fetchTrainingDayExercises(dayId: trainingDayId);
    final exercise = exercisesRepo.exercises.firstWhere(
      (element) => element.id! == exercises.first.exerciseId,
    );
    _initLists(0);
    emit(
      NextExercise(
        totalVolume,
        exercise: exercise,
        trainingDayExercise: exercises.first,
        index: 0,
      ),
    );
  }

  void completeExercise() {
    _logExercise(currentIndex);
    currentIndex++;
    if (currentIndex == exercises.length) {
      emit(FinishedWorkout());
      return;
    } else {
      emit(Resting());
    }
  }

  void skipExercise() {
    currentIndex++;
    if (currentIndex == exercises.length) {
      emit(FinishedWorkout());
      return;
    } else {
      nextWorkout();
    }
  }

  Future<void> _logExercise(int index) async {
    int totalWeight = 0;
    int totalReps = 0;
    int maxWeight = 0;
    for (var element in _weights) {
      if (element > maxWeight) {
        maxWeight = element;
      }
      totalWeight += element;
    }
    for (var element in _reps) {
      totalReps += element;
    }
    int volume = totalReps * totalWeight;
    final exerciseLog = ExerciseLog(
      exerciseId: exercises[index].exerciseId,
      date: DateTime.now().toIso8601String(),
      volume: volume,
      maxWeight: maxWeight,
    );
    await exercisesLogRepo.addExerciseLog(exerciseLog: exerciseLog);
    totalVolume += volume;
  }

  void nextWorkout() {
    final exercise = exercisesRepo.exercises.firstWhere(
      (element) => element.id! == exercises[currentIndex].exerciseId,
    );
    _initLists(currentIndex);
    emit(
      NextExercise(
        totalVolume,
        exercise: exercise,
        trainingDayExercise: exercises[currentIndex],
        index: currentIndex,
      ),
    );
  }

  void updateWeight(int index, int weight) {
    _weights[index] = weight;
  }

  void updateReps(int index, int reps) {
    _reps[index] = reps;
  }
}
