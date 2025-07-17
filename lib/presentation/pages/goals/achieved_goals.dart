import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/presentation/cubits/goals/list/goals_list_cubit.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AchievedGoals extends StatefulWidget {
  const AchievedGoals({super.key});

  @override
  State<AchievedGoals> createState() => _AchievedGoalsState();
}

class _AchievedGoalsState extends State<AchievedGoals> {
  @override
  void initState() {
    super.initState();
    context.read<GoalsListCubit>().loadAchievedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Achieved Goals')),
      body: BlocBuilder<GoalsListCubit, GoalsListState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FullList) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: CardList(
                items: state.goals,
                builder: (item) => GoalCard(goal: item),
              ),
            );
          } else {
            return NoElements(message: StringManager.noAchievedGoalsFound);
          }
        },
      ),
    );
  }
}
