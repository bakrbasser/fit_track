import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/cubits/goals/add/goals_add_cubit.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGoal extends StatelessWidget {
  AddGoal({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Goal')),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Exercise',
                  style: FontsManager.lexendBold(size: 25),
                ),
              ),
              SizedBox(height: 15),
              ExerciseAutoComplete(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Targeted Weight',
                  style: FontsManager.lexendBold(size: 25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                style: FontsManager.lexendRegular(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  context.read<AddGoalCubit>().weight = int.parse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManager.noSelectedWeight;
                  }
                  int? weight = int.tryParse(value);
                  if (weight == null) {
                    return 'Enter a valid weight';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Targeted Reps',
                  style: FontsManager.lexendBold(size: 25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                style: FontsManager.lexendRegular(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManager.noSelectedReps;
                  }
                  int? reps = int.tryParse(value);
                  if (reps == null) {
                    return 'Enter valid Number Of Reps';
                  }
                  return null;
                },
                onSaved: (value) {
                  context.read<AddGoalCubit>().reps = int.parse(value!);
                },
              ),
              SizedBox(height: 30),
              Buttons.CostumeButton(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final cub = context.read<AddGoalCubit>();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await context.read<AddGoalCubit>().addGoal();
                    nav.pop(cub.isAdded);
                  }
                },
                child: Text('Add Goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseAutoComplete extends StatelessWidget {
  const ExerciseAutoComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Exercise>(
      optionsBuilder: (textEditingValue) {
        return context.read<ExercisesListCubit>().exercises.where(
          (element) => element.name.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },
      displayStringForOption: (option) => option.name,
      onSelected:
          (option) => context.read<AddGoalCubit>().exerciseId = option.id,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                style: FontsManager.lexendRegular(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManager.emptyExerciseField;
                  } else {
                    return null;
                  }
                },
              ),
    );
  }
}
