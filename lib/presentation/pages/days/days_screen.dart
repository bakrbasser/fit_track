import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/presentation/cubits/days/list/days_list_cubit.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysScreen extends StatefulWidget {
  const DaysScreen({super.key});

  @override
  State<DaysScreen> createState() => _DaysScreenState();
}

class _DaysScreenState extends State<DaysScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DaysListCubit>().loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Training Days')),
      body: TrainingDaysList(mode: TrainingDayCardMode.details),
    );
  }
}

class TrainingDaysList extends StatelessWidget {
  const TrainingDaysList({super.key, required this.mode});

  final TrainingDayCardMode mode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DaysListCubit, DaysListState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FullList) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: CardList(
              items: state.days,
              builder:
                  (item) => TrainingDayCard(mode: mode, trainingDay: item!),
            ),
          );
        } else {
          return NoElements(message: StringManager.noTrainingDaysFound);
        }
      },
    );
  }
}
