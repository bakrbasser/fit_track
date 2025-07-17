import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:fit_track/domain/entities/training_day.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/presentation/cubits/days/add/add_day_cubit.dart';
import 'package:fit_track/presentation/cubits/days/list/days_list_cubit.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/add/add_plan_cubit.dart';
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
    return IconCard(
      icon: AssetsManager.dumbbell,
      title: exercise.name,
      description: exercise.instructions,
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
    return IconCard(
      icon: AssetsManager.dumbbell,
      title: exercise.name,
      description: 'Target ${goal.weight} kg ${goal.reps} times',
    );
  }
}

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
                decoration: InputDecoration(
                  filled: false,
                  hintText: '$sets',
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                ),
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
                decoration: InputDecoration(
                  filled: false,
                  hintText: '$reps',
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                ),
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
    return IconCard(
      icon: plan.icon ?? AssetsManager.dumbbell,
      title: plan.name,
      description: plan.description,
      action: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              plan.isActivated ? ColorsManager.grey : ColorsManager.darkGreen,
        ),
        onPressed: () async {
          plan.isActivated
              ? await context.read<PlansListCubit>().deactivatePlan()
              : await context.read<PlansListCubit>().activatePlan(plan: plan);
        },
        child: Text(
          plan.isActivated ? 'De-Activate' : 'Activate',
          style: FontsManager.lexendMedium(color: Colors.white, size: 14),
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

class AddDayCard extends StatefulWidget {
  const AddDayCard({super.key, required this.index});
  final int index;

  @override
  State<AddDayCard> createState() => _AddDayCardState();
}

class _AddDayCardState extends State<AddDayCard> {
  int exercisesCount = 0;
  String title = '';
  @override
  void initState() {
    super.initState();
    title = 'Day ${widget.index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: FontsManager.lexendMedium(size: 22)),
            Text(
              '$exercisesCount exercises',
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
            final planCubit = context.read<AddPlanCubit>();
            final TrainingDay? day = await showModalBottomSheet(
              context: context,
              builder:
                  (context) => BlocProvider(
                    create: (context) => DaysListCubit(),
                    child: TrainingDayBottomBar(),
                  ),
            );
            if (day != null) {
              exercisesCount = await dayCubit.dayExercisesCount(day.id!);
              planCubit.trainingDaysIds[widget.index] = day.id!;

              setState(() {
                title = day.name;
              });
            }
          },
          icon: Icon(Icons.list, color: Colors.white),
        ),
        SizedBox(width: 5),
        // Create New Training Day
        IconButton(
          onPressed: () async {
            final planCubit = context.read<AddPlanCubit>();
            final paras =
                await Navigator.pushNamed(context, Routes.addDay)
                    as Map<String, Object>;
            if (paras['isAdded'] as bool) {
              planCubit.trainingDaysIds[widget.index] = paras['id'] as int;

              setState(() {
                title = paras['name'] as String;
                exercisesCount = paras['count'] as int;
              });
            }
          },
          icon: Icon(Icons.add, color: Colors.white),
        ),
      ],
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
        IconButton(
          onPressed: () {
            // TODO : Edit training day screen
          },
          icon: Icon(Icons.edit, color: Colors.white),
        ),
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
