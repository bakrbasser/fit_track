import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/routes/routes_manager.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExercisesListCubit>().loadList();
  }

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
              child: _ExercisesList(),
            );
          } else {
            return NoElements(message: StringManager.noExerciseFound);
          }
        },
      ),
    );
  }
}

class _ExercisesList extends StatefulWidget {
  const _ExercisesList();

  @override
  State<_ExercisesList> createState() => _ExercisesListState();
}

class _ExercisesListState extends State<_ExercisesList> {
  late List<Exercise> exercises;

  @override
  void initState() {
    super.initState();
    exercises = context.read<ExercisesListCubit>().exercises;
  }

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
  const _AddExerciseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final cubit = context.read<ExercisesListCubit>();
        final isAdded =
            await Navigator.pushNamed(context, Routes.addExercises) as bool;
        if (isAdded) {
          cubit.loadList();
        }
      },
      icon: Icon(Icons.add, size: 30),
    );
  }
}
