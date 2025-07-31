import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/presentation/cubits/days/add/add_day_cubit.dart';
import 'package:fit_track/presentation/cubits/days/list/days_list_cubit.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/cubits/goals/list/goals_list_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/list/plans_list_cubit.dart';
import 'package:fit_track/presentation/routes/routes_manager.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.action,
  });
  final String icon;
  final String title;
  final String? description;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          height: ScreenSizeHelper.width_P(context, 0.15),
          width: ScreenSizeHelper.width_P(context, 0.15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(icon, scale: 0.7, color: Colors.white),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: FontsManager.lexendMedium(size: 22)),
              Text(
                description ?? 'No description',
                style: FontsManager.lexendMedium(
                  color: ColorsManager.textGrey,
                  size: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ],
          ),
        ),
        if (action != null) Spacer(),
        if (action != null) action!,
      ],
    );
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) {
        return showConfirmationDialog(
          context,
          StringManager.deleteExerciseConfirmMessage,
        );
      },
      onDismissed: (_) async {
        context.read<ExercisesListCubit>().deleteExercise(exercise.id!);
        context.read<GoalsListCubit>().loadUnAchievedList();
      },
      key: Key(exercise.id.toString()),
      child: InkWell(
        onTap: () async {
          final cub = context.read<ExercisesListCubit>();
          // receives is updated on updating the exercise
          bool? isUpdated =
              await Navigator.pushNamed(
                    context,
                    Routes.exerciseDetails,
                    arguments: exercise,
                  )
                  as bool?;
          if (isUpdated != null && isUpdated == true) {
            cub.loadList();
          }
        },
        child: IconCard(
          icon: AssetsManager.dumbbell,
          title: exercise.name,
          description: exercise.instructions,
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.goal});
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    Exercise exercise = context.read<ExercisesListCubit>().exerciseById(
      goal.exerciseId,
    );
    return Dismissible(
      confirmDismiss: (_) {
        return showConfirmationDialog(
          context,
          StringManager.deleteGoalConfirmMessage,
        );
      },
      onDismissed: (_) {
        context.read<GoalsListCubit>().deleteGoal(goal);
      },
      key: Key(exercise.id.toString()),
      child: IconCard(
        icon: AssetsManager.dumbbell,
        title: exercise.name,
        description: 'Target ${goal.weight} kg ${goal.reps} times',
      ),
    );
  }
}

// Add new day insider exercise Card
class MultipleSelectionExerciseCard extends StatefulWidget {
  const MultipleSelectionExerciseCard({super.key, required this.exercise});
  final Exercise exercise;
  @override
  State<MultipleSelectionExerciseCard> createState() =>
      _MultipleStateSelectionExerciseCard();
}

class _MultipleStateSelectionExerciseCard
    extends State<MultipleSelectionExerciseCard> {
  bool selected = false;
  int reps = 10;
  int sets = 3;
  void onChanged(bool? value) {
    setState(() {
      selected = value!;
    });
    context.read<AddDayCubit>().selectExercise(
      value!,
      widget.exercise.id!,
      sets,
      reps,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: selected, onChanged: onChanged, shape: CircleBorder()),
        SizedBox(
          width: ScreenSizeHelper.width_P(context, 0.5),
          child: Text(
            widget.exercise.name,
            style: FontsManager.lexendMedium(size: 22),
          ),
        ),
        Spacer(),

        Column(
          children: [
            Text('Sets', style: FontsManager.lexendRegular(size: 14)),
            SizedBox(
              width: 30,
              height: 40,
              child: TextField(
                keyboardType: TextInputType.number,
                style: FontsManager.lexendRegular(size: 14),

                readOnly: !selected,
                decoration: InputDecoration(
                  filled: false,
                  hintText: '$sets',
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  if (value == '') {
                    sets = 3;
                  } else {
                    sets = int.parse(value);
                  }
                  context.read<AddDayCubit>().updateSets(
                    widget.exercise.id!,
                    sets,
                  );
                },
              ),
            ),
          ],
        ),

        SizedBox(width: 40),
        Column(
          children: [
            Text('Reps', style: FontsManager.lexendRegular(size: 14)),
            // Text(reps.toString(), style: FontsManager.lexendMedium()),
            SizedBox(
              width: 30,
              height: 40,
              child: TextField(
                style: FontsManager.lexendRegular(size: 14),
                keyboardType: TextInputType.number,
                readOnly: !selected,
                decoration: InputDecoration(
                  filled: false,
                  hintText: '$reps',
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  if (value == '') {
                    reps = 10;
                  } else {
                    reps = int.parse(value);
                  }
                  context.read<AddDayCubit>().updateReps(
                    widget.exercise.id!,
                    reps,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({super.key, required this.plan});
  final TrainingPlan plan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var cubit = context.read<PlansListCubit>();
        var isUpdated =
            await Navigator.pushNamed(
                  context,
                  Routes.updatePlan,
                  arguments: plan,
                )
                as bool?;
        if (isUpdated != null && isUpdated == true) {
          cubit.loadList();
        }
      },
      child: Dismissible(
        key: Key(plan.id.toString()),
        confirmDismiss: (direction) {
          return showConfirmationDialog(
            context,
            StringManager.deleteTrainingPlanConfirmMessage,
          );
        },

        onDismissed: (direction) {
          context.read<PlansListCubit>().deleteTrainingPlan(plan.id!);
        },
        child: IconCard(
          icon: plan.icon ?? AssetsManager.dumbbell,
          title: plan.name,
          description: plan.description,
          action: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  plan.isActivated
                      ? ColorsManager.grey
                      : ColorsManager.darkGreen,
            ),
            onPressed: () async {
              plan.isActivated
                  ? await context.read<PlansListCubit>().deactivatePlan()
                  : await context.read<PlansListCubit>().activatePlan(
                    plan: plan,
                  );
            },
            child: Text(
              plan.isActivated ? 'De-Activate' : 'Activate',
              style: FontsManager.lexendMedium(color: Colors.white, size: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class PlanIcon extends StatelessWidget {
  const PlanIcon({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, icon);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  const DayCard({super.key, required this.day});
  final TrainingDay day;

  @override
  Widget build(BuildContext context) {
    return IconCard(
      icon: IconsManager.power,
      title: day.name,
      description: day.description,
      // for seeing training day details
      action: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
    );
  }
}

// ignore: must_be_immutable
class AddDayCard extends StatefulWidget {
  AddDayCard({
    super.key,
    required this.index,
    this.day,
    this.exercisesCount = 0,
  });
  final int index;
  TrainingDay? day;
  int exercisesCount;
  @override
  State<AddDayCard> createState() => _AddDayCardState();
}

class _AddDayCardState extends State<AddDayCard> {
  String title = '';
  @override
  void initState() {
    super.initState();
    widget.day ??
        context.read<DaysListCubit>().dayExercisesCount(widget.day!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.index.toString()),
      confirmDismiss: (direction) {
        return showConfirmationDialog(
          context,
          StringManager.deleteDayFromPlanConfirmMessage,
        );
      },
      onDismissed: (direction) {
        context.read<DaysListCubit>().removeDayFromNewPlan(widget.index);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.day != null ? widget.day!.name : 'Day ${widget.index}',
                style: FontsManager.lexendMedium(size: 22),
              ),
              Text(
                '${widget.exercisesCount} exercises',
                style: FontsManager.lexendMedium(
                  color: ColorsManager.textGrey,
                  size: 16,
                ),
              ),
            ],
          ),
          Spacer(),
          // Select from existing days
          IconButton(
            onPressed: () async {
              final dayCubit = context.read<DaysListCubit>();
              final TrainingDay? day = await showModalBottomSheet(
                context: context,
                builder:
                    (context) => BlocProvider(
                      create: (context) => DaysListCubit(),
                      child: TrainingDayBottomBar(),
                    ),
              );
              if (day != null) {
                var assigned = dayCubit.assignDayToPlan(day, widget.index);
                if (assigned) {
                  widget.exercisesCount = await dayCubit.dayExercisesCount(
                    day.id!,
                  );
                  setState(() {
                    widget.day = day;
                  });
                }
              }
            },
            icon: Icon(Icons.list, color: Colors.white),
          ),
          SizedBox(width: 5),
          // Create New Training Day
          IconButton(
            onPressed: () async {
              final addedDayInfo =
                  await Navigator.pushNamed(context, Routes.addDay)
                      as Map<String, dynamic>?;

              if (addedDayInfo != null) {
                setState(() {
                  widget.day = addedDayInfo['day'];
                  widget.exercisesCount = addedDayInfo['count'];
                });
              }
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class TrainingDayCard extends StatelessWidget {
  const TrainingDayCard({
    super.key,
    required this.trainingDay,
    required this.mode,
  });
  final TrainingDay trainingDay;
  final TrainingDayCardMode mode;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: ScreenSizeHelper.width_P(context, 0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trainingDay.name,
                style: FontsManager.lexendMedium(size: 22),
              ),
              Text(
                trainingDay.description ?? 'No description',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FontsManager.lexendMedium(
                  color: ColorsManager.textGrey,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        Spacer(),

        SizedBox(width: 5),
        // This button select training for a training plan or show the day detail depending on the parent screen
        IconButton(
          onPressed: () {
            Navigator.pop(context, trainingDay);
          },
          icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ],
    );
  }
}

enum TrainingDayCardMode { select, details }

class CardList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) builder;

  const CardList({super.key, required this.items, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: builder(items[index]),
          ),
    );
  }
}
