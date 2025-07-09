import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/domain/entities/goal.dart';
import 'package:fit_track/presentation/cubits/goals/list/goals_list_cubit.dart';
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
    context.read<GoalsListCubit>().loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goals'), actions: [_AddGoalButton()]),
      body: BlocBuilder<GoalsListCubit, GoalsListState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FullList) {
            return _GoalsList();
          } else {
            return NoElements(message: StringManager.noGoalsFound);
          }
        },
      ),
    );
  }
}

class _GoalsList extends StatefulWidget {
  const _GoalsList();

  @override
  State<_GoalsList> createState() => _GoalsListState();
}

class _GoalsListState extends State<_GoalsList> {
  late final List<Goal> goals;

  @override
  void initState() {
    super.initState();
    goals = context.read<GoalsListCubit>().goals;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
        // final cubit = context.read<GoalsListCubit>();
        // final isAdded =
        //     await Navigator.pushNamed(context, Routes.addGoal) as bool;
        // if (isAdded) {
        //   cubit.loadList();
        // }
      },
      icon: Icon(Icons.add, size: 30),
    );
  }
}
