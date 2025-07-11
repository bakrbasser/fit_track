import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/presentation/cubits/exercises/list/exercises_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });
  final String icon;
  final String title;
  final String? description;

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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(icon, scale: 0.7),
          ),
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: FontsManager.lexendMedium(size: 22)),
            SizedBox(
              width: ScreenSizeHelper.width_P(context, 0.65),
              child: Text(
                description ?? 'No description',
                style: FontsManager.lexendMedium(
                  color: ColorsManager.textGrey,
                  size: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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

class PlanCard extends StatelessWidget {
  const PlanCard({super.key, required this.plan});
  final TrainingPlan plan;

  @override
  Widget build(BuildContext context) {
    return IconCard(
      icon: plan.icon ?? AssetsManager.dumbbell,
      title: plan.name,
      description: plan.description,
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

class AddDayCard extends StatefulWidget {
  const AddDayCard({super.key, required this.index});
  final int index;

  @override
  State<AddDayCard> createState() => _AddDayCardState();
}

class _AddDayCardState extends State<AddDayCard> {
  int trainingCount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day ${widget.index + 1}',
              style: FontsManager.lexendMedium(size: 22),
            ),
            Text(
              '$trainingCount exercises',
              style: FontsManager.lexendMedium(
                color: ColorsManager.textGrey,
                size: 16,
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ],
    );
  }
}
