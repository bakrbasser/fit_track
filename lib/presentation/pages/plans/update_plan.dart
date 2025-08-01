import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/presentation/cubits/days/list/days_list_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/update/update_plan_cubit.dart';
import 'package:fit_track/presentation/pages/plans/add_plan.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePlanScreen extends StatefulWidget {
  const UpdatePlanScreen({super.key, required this.plan});
  final TrainingPlan plan;

  @override
  State<UpdatePlanScreen> createState() => _UpdatePlanScreenState();
}

class _UpdatePlanScreenState extends State<UpdatePlanScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.plan.name;
    descriptionController.text = widget.plan.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePlanCubit, UpdatePlanState>(
      listener: (context, state) {
        if (state is UpdatePlan) {
          context.read<DaysListCubit>().updatePlanDays(planId: widget.plan.id!);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.plan.name),
          actions: [UpdateIcon(icon: widget.plan.icon)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlanNameField(
                controller: nameController,
                onChanged: (value) {
                  context.read<UpdatePlanCubit>().name = value;
                },
              ),
              SizedBox(height: 30),
              PlanDescriptionField(
                controller: descriptionController,
                onChanged: (value) {
                  context.read<UpdatePlanCubit>().description = value;
                },
              ),
              SizedBox(height: 30),
              UpdatePlanDaysList(trainingPlanID: widget.plan.id!),
              Buttons.costumeButton(
                onPressed: () async {
                  var nav = Navigator.of(context);
                  await context.read<UpdatePlanCubit>().update();
                  nav.pop(true);
                },
                child: Text('Update Training Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UpdateIcon extends StatefulWidget {
  UpdateIcon({super.key, this.icon});
  String? icon;

  @override
  State<UpdateIcon> createState() => _UpdateIconState();
}

class _UpdateIconState extends State<UpdateIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final cubit = context.read<UpdatePlanCubit>();
        final icon = await showIconsDialog(context);
        cubit.icon = icon!;
        setState(() {
          widget.icon = icon;
        });
      },

      icon: ImageIcon(AssetImage(widget.icon ?? AssetsManager.dumbbell)),
    );
  }
}

class UpdatePlanDaysList extends StatefulWidget {
  const UpdatePlanDaysList({super.key, required this.trainingPlanID});
  final int trainingPlanID;

  @override
  State<UpdatePlanDaysList> createState() => _UpdatePlanDaysListState();
}

class _UpdatePlanDaysListState extends State<UpdatePlanDaysList> {
  @override
  void initState() {
    super.initState();
    context.read<DaysListCubit>().loadPlanDays(widget.trainingPlanID);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DaysListCubit, DaysListState>(
        builder: (context, state) {
          if (state is FullList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Days', style: FontsManager.lexendBold(size: 25)),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          //Fix getting out of range
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
                          child: AddDayCard(
                            index: index,
                            day: state.days[index],
                            exercisesCount: state.counts[index],
                          ),
                        ),
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
