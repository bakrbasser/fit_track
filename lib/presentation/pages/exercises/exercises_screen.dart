import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/widgets/exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercises'), actions: [_AddExerciseButton()]),
      body: BlocBuilder<ExercisesListCubit, ExercisesListState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FullList) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: _ExercisesList(exercises: state.exercises),
            );
          } else {
            return _NoExercises();
          }
        },
      ),
    );
  }
}

class _ExercisesList extends StatelessWidget {
  const _ExercisesList({super.key, required this.exercises});

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: ExerciseCard(exercise: exercises[index]),
          ),
    );
  }
}

class _AddExerciseButton extends StatelessWidget {
  const _AddExerciseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 30));
  }
}

class _NoExercises extends StatelessWidget {
  const _NoExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenSizeHelper.height_P(context, 0.2)),
      child: Text(
        StringManager.noExerciseFound,
        style: FontsManager.lexendMedium(size: 22),
        textAlign: TextAlign.center,
      ),
    );
  }
}
