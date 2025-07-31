import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/presentation/cubits/days/list/days_list_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/add/add_plan_cubit.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/dialogs.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({super.key});

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPlanCubit, AddPlanState>(
      listener: (context, state) {
        if (state is Error) {
          showConfirmationDialog(context, state.message);
        }
        if (state is AddedPlan) {
          context.read<DaysListCubit>().addPlanDays(state.plan.id!);
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Training Plan'),
          actions: [ChooseIcon()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlanNameField(
                  onChanged: (value) {
                    context.read<AddPlanCubit>().name = value;
                  },
                ),
                SizedBox(height: 30),
                PlanDescriptionField(
                  onChanged: (value) {
                    context.read<AddPlanCubit>().description = value;
                  },
                ),
                SizedBox(height: 30),

                AddPlanDaysList(),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Buttons.costumeButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<AddPlanCubit>().addPlan();
                      }
                    },
                    child: Text('Add Training Plan'),
                  ),
                ),
              ],
            ),
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
      onPressed: () async {
        final cubit = context.read<AddPlanCubit>();
        final icon = await showIconsDialog(context);
        cubit.icon = icon!;
      },
      style: TextButton.styleFrom(
        textStyle: FontsManager.lexendRegular(size: 18),
        foregroundColor: Colors.white,
      ),
      child: Text('Icon'),
    );
  }
}

class PlanNameField extends StatelessWidget {
  const PlanNameField({super.key, required this.onChanged, this.controller});
  final void Function(String value) onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        onChanged(value);
      },
    );
  }
}

class PlanDescriptionField extends StatelessWidget {
  const PlanDescriptionField({
    super.key,
    required this.onChanged,
    this.controller,
  });
  final void Function(String value) onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        hintText: 'Description',
      ),
      style: FontsManager.lexendRegular(),
      maxLines: 4,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}

class AddPlanDaysList extends StatefulWidget {
  const AddPlanDaysList({super.key});

  @override
  State<AddPlanDaysList> createState() => _AddPlanDaysListState();
}

class _AddPlanDaysListState extends State<AddPlanDaysList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Text('Days', style: FontsManager.lexendBold(size: 25)),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    context.read<DaysListCubit>().numberOfDays++;
                  });
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: context.read<DaysListCubit>().numberOfDays,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AddDayCard(index: index),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
