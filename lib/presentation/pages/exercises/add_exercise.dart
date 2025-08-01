import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/presentation/cubits/exercises/add/add_exercise_cubit.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExercise extends StatelessWidget {
  AddExercise({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Exercise')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text('Name', style: FontsManager.lexendBold(size: 25)),
              ),
              SizedBox(height: 15),
              _NameField(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Instructions',
                  style: FontsManager.lexendBold(size: 25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(contentPadding: EdgeInsets.all(12)),
                style: FontsManager.lexendRegular(),
                maxLines: 4,
                onChanged: (value) {
                  context.read<AddExerciseCubit>().instructions = value;
                },
              ),
              SizedBox(height: 30),
              Buttons.costumeButton(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final cub = context.read<AddExerciseCubit>();
                  if (_formKey.currentState!.validate()) {
                    await context.read<AddExerciseCubit>().addExercise();
                    nav.pop(cub.isAdded);
                  }
                },
                child: Text('Add Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: FontsManager.lexendRegular(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringManager.emptyNameField;
        } else if (value.length < 3) {
          return StringManager.shortNameField;
        }
        return null;
      },
      onChanged: (value) {
        context.read<AddExerciseCubit>().name = value;
      },
    );
  }
}
