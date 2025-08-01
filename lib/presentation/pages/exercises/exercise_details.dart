import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:fit_track/presentation/cubits/charts/charts_cubit.dart';
import 'package:fit_track/presentation/routes/routes_manager.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:fit_track/presentation/widgets/line_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({super.key, required this.exercise});
  final Exercise exercise;

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  late bool? isUpdated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        actions: [
          IconButton(
            onPressed: () async {
              isUpdated =
                  await Navigator.pushNamed(
                        context,
                        Routes.updateExercise,
                        arguments: widget.exercise,
                      )
                      as bool?;
              if (isUpdated != null && isUpdated == true) {
                setState(() {
                  Navigator.pop(context, isUpdated);
                });
              }
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              'Instructions',
              style: FontsManager.lexendBold(
                size: 25,
                color: ColorsManager.offWhite,
              ),
            ),
            Text(
              textAlign: TextAlign.start,
              widget.exercise.instructions ?? 'No available instructions',
              style: FontsManager.lexendMedium(
                size: 18,
                color: ColorsManager.textGrey,
              ),
            ),
            _Chart(exerciseId: widget.exercise.id!),
          ],
        ),
      ),
    );
  }
}

class _Chart extends StatefulWidget {
  const _Chart({required this.exerciseId});
  final int exerciseId;

  @override
  State<_Chart> createState() => __ChartState();
}

class __ChartState extends State<_Chart> {
  @override
  void initState() {
    super.initState();
    context.read<ChartsCubit>().initExerciseCharts(
      exerciseId: widget.exerciseId,
    );
  }

  int selectedButton = 0;

  Widget chart = SizedBox();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Buttons.costumeButton(
              width: ScreenSizeHelper.width_P(context, 0.4),
              backgroundColor:
                  selectedButton == 0
                      ? ColorsManager.grey
                      : ColorsManager.darkGreen,
              foregroundColor: ColorsManager.offWhite,
              onPressed: () {
                if (selectedButton != 0) {
                  setState(() {
                    selectedButton = 0;
                    chart = ExerciseVolumeChart();
                  });
                }
              },
              child: Text('Volume'),
            ),
            Spacer(),
            Buttons.costumeButton(
              width: ScreenSizeHelper.width_P(context, 0.4),
              backgroundColor:
                  selectedButton == 1
                      ? ColorsManager.grey
                      : ColorsManager.darkGreen,
              foregroundColor: ColorsManager.offWhite,
              onPressed: () {
                if (selectedButton != 1) {
                  setState(() {
                    selectedButton = 1;
                    chart = ExerciseMaxWeightChart();
                  });
                }
              },
              child: Text('Weight'),
            ),
          ],
        ),

        BlocListener<ChartsCubit, ChartsState>(
          listener: (context, state) {
            if (state is ChartFinishedLoading) {
              chart = ExerciseVolumeChart();
              setState(() {});
            }
          },
          child: chart,
        ),
      ],
    );
  }
}
