import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/exercises/update/update_exercise_cubit.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateExercise extends StatefulWidget {
  const UpdateExercise({super.key, required this.exercise});
  final Exercise exercise;

  @override
  State<UpdateExercise> createState() => _UpdateExerciseState();
}

class _UpdateExerciseState extends State<UpdateExercise> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController instructions = TextEditingController();
  @override
  void initState() {
    super.initState();
    name.text = widget.exercise.name;
    instructions.text = widget.exercise.instructions ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Exercise')),
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
              _NameField(widget.exercise.name, name),
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
                controller: instructions,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: widget.exercise.instructions,
                ),
                style: FontsManager.lexendRegular(),
                maxLines: 4,
                onChanged: (value) {
                  context.read<UpdateExerciseCubit>().instructions = value;
                },
              ),
              SizedBox(height: 30),
              Buttons.costumeButton(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final cub = context.read<UpdateExerciseCubit>();
                  if (_formKey.currentState!.validate()) {
                    await cub.update();
                    nav.pop(cub.isUpdated);
                  }
                },
                child: Text('Update Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField(this.name, this.instructions);
  final String name;
  final TextEditingController instructions;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: instructions,
      style: FontsManager.lexendRegular(),
      decoration: InputDecoration(hintText: name),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringManager.emptyNameField;
        } else if (value.length < 3) {
          return StringManager.shortNameField;
        }
        return null;
      },
      onChanged: (value) {
        context.read<UpdateExerciseCubit>().name = value;
      },
    );
  }
}
