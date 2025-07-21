import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/presentation/cubits/days/add/add_day_cubit.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTrainingDay extends StatefulWidget {
  const AddTrainingDay({super.key});

  @override
  State<AddTrainingDay> createState() => _AddTrainingDayState();
}

class _AddTrainingDayState extends State<AddTrainingDay> {
  @override
  void initState() {
    super.initState();
    context.read<ExercisesListCubit>().loadList();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Training Day')),
      body: Padding(
        padding: EdgeInsets.all(8),
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
              TextFormField(
                style: FontsManager.lexendRegular(),
                onSaved: (value) {
                  context.read<AddDayCubit>().name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManager.emptyNameField;
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Description',
                  style: FontsManager.lexendBold(size: 25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(contentPadding: EdgeInsets.all(8)),
                style: FontsManager.lexendRegular(),
                maxLines: 4,
                onSaved: (value) {
                  context.read<AddDayCubit>().description = value;
                },
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  'Exercises',
                  style: FontsManager.lexendBold(size: 25),
                ),
              ),
              ExercisesSelectionList(),
              Buttons.CostumeButton(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final cubit = context.read<AddDayCubit>();
                  if (_formKey.currentState!.validate()) {
                    if (cubit.exercises.isNotEmpty) {
                      _formKey.currentState!.save();
                      await cubit.addDay();
                      nav.pop({
                        'isAdded': cubit.isAdded,
                        'id': cubit.id,
                        'name': cubit.name,
                        'count': cubit.exercises.length,
                      });
                    }
                  }
                },
                child: Text('Save Training Day'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExercisesSelectionList extends StatelessWidget {
  const ExercisesSelectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesListCubit, ExercisesListState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FullList) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CardList(
                items: state.exercises,
                builder:
                    (item) => MultipleSelectionExerciseCard(exercise: item),
              ),
            ),
          );
        } else {
          return NoElements(message: StringManager.noExerciseFound);
        }
      },
    );
  }
}
