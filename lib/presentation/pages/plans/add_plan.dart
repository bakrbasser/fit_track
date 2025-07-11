import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/presentation/cubits/plans/add/add_plan_cubit.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlan extends StatelessWidget {
  AddPlan({super.key, required this.numberOfDays});
  final int numberOfDays;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Training Plan'), actions: [ChooseIcon()]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlanNameField(),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Description',
                ),
                style: FontsManager.lexendRegular(),
                maxLines: 5,
                onChanged: (value) {
                  context.read<AddPlanCubit>().description = value;
                },
              ),

              SizedBox(height: 30),
              Text('Days', style: FontsManager.lexendBold(size: 25)),
              SizedBox(height: 15),
              DaysList(numberOfDays: numberOfDays),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseIcon extends StatelessWidget {
  const ChooseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        (showIconsDialog(context));
      },
      style: TextButton.styleFrom(
        textStyle: FontsManager.lexendRegular(size: 18),
        foregroundColor: Colors.white,
      ),
      child: Text('Icon'),
    );
  }
}

class _PlanNameField extends StatelessWidget {
  const _PlanNameField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: 'Plan Name'),
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
        context.read<AddPlanCubit>().name = value;
      },
    );
  }
}

class DaysList extends StatelessWidget {
  const DaysList({super.key, required this.numberOfDays});
  final int numberOfDays;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: numberOfDays,
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AddDayCard(index: index),
            ),
      ),
    );
  }
}
