import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:fit_track/presentation/cubits/goals/list/goals_list_cubit.dart';
import 'package:fit_track/presentation/routes/routes_manager.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GoalsListCubit>().loadUnAchievedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
        leading: ViewAchievedGoals(),
        actions: [_AddGoalButton()],
      ),
      body: BlocBuilder<GoalsListCubit, GoalsListState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FullList) {
            return GoalsList(goals: state.goals);
          } else {
            return NoElements(message: StringManager.noGoalsFound);
          }
        },
      ),
    );
  }
}

class GoalsList extends StatelessWidget {
  const GoalsList({super.key, required this.goals});

  final List<Goal> goals;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: goals.length,
      itemBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: GoalCard(goal: goals[index]),
          ),
    );
  }
}

class _AddGoalButton extends StatelessWidget {
  const _AddGoalButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final cubit = context.read<GoalsListCubit>();
        final isAdded =
            await Navigator.pushNamed(context, Routes.addGoal) as bool;
        if (isAdded) {
          cubit.loadUnAchievedList();
        }
      },
      icon: Icon(Icons.add, size: 30),
    );
  }
}

class ViewAchievedGoals extends StatelessWidget {
  const ViewAchievedGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.achievedGoals);
      },
      icon: Icon(Icons.emoji_events),
    );
  }
}
