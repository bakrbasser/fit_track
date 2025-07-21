import 'dart:async';

import 'package:fit_track/core/formatters.dart';
import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/presentation/cubits/workout_session/workout_session_cubit.dart';
import 'package:fit_track/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutSessionCubit>().loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Session')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<WorkoutSessionCubit, WorkoutSessionState>(
                builder: (context, state) {
                  if (state is WorkoutsLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is NextExercise) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exercise ${state.index + 1}: ${state.exercise.name}',
                          style: FontsManager.lexendBold(size: 22),
                        ),
                        SizedBox(
                          height: ScreenSizeHelper.height_P(context, 0.5),
                          child: WeightRepsList(
                            sets: state.trainingDayExercise.sets,
                            reps: state.trainingDayExercise.reps,
                          ),
                        ),
                        SizedBox(height: 30),
                        Buttons.CostumeButton(
                          //TODO
                          onPressed: () {
                            context
                                .read<WorkoutSessionCubit>()
                                .completeExercise();
                          },
                          child: Text('Complete Exercise'),
                        ),
                        SizedBox(height: 10),
                        Buttons.CostumeButton(
                          onPressed: () {
                            context.read<WorkoutSessionCubit>().skipExercise();
                          },
                          child: Text('Skip Exercise'),
                          backgroundColor: ColorsManager.grey,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    );
                  } else if (state is Resting) {
                    return SizedBox(
                      height: ScreenSizeHelper.height_P(context, 0.7),
                      child: TimerCircularProgress(),
                    );
                  } else {
                    return Placeholder();
                  }
                },
              ),
              SizedBox(height: 30),
              //Session Summary
              Text('Session Summary', style: FontsManager.lexendBold(size: 22)),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'Session Volume :',
                    style: FontsManager.lexendMedium(
                      size: 18,
                      color: ColorsManager.textGrey,
                    ),
                  ),
                  Spacer(),
                  //TODO settings choose weight measure unit
                  TotalVolume(),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Session Time :',
                    style: FontsManager.lexendMedium(
                      size: 18,
                      color: ColorsManager.textGrey,
                    ),
                  ),
                  Spacer(),
                  SessionTime(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SessionTime extends StatefulWidget {
  const SessionTime({super.key});

  @override
  State<SessionTime> createState() => _SessionTimeState();
}

class _SessionTimeState extends State<SessionTime> {
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
    stopwatch.start();
  }

  @override
  void dispose() {
    super.dispose();
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      HH_MM(stopwatch.elapsed),
      style: FontsManager.lexendMedium(size: 18, color: ColorsManager.offWhite),
    );
  }
}

class TotalVolume extends StatefulWidget {
  const TotalVolume({super.key});

  @override
  State<TotalVolume> createState() => _TotalVolumeState();
}

class _TotalVolumeState extends State<TotalVolume> {
  int totalVolume = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutSessionCubit, WorkoutSessionState>(
      listener: (context, state) {
        if (state is NextExercise) {
          setState(() {
            totalVolume = state.totalVolume;
          });
        }
      },
      child: Text(
        '$totalVolume Kgs',
        style: FontsManager.lexendMedium(
          size: 18,
          color: ColorsManager.offWhite,
        ),
      ),
    );
  }
}

class WeightRepsList extends StatelessWidget {
  const WeightRepsList({super.key, required this.sets, required this.reps});
  final int sets;
  final int reps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sets,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                WeightsRepsTile(index: index, type: TileType.Weight),
                WeightsRepsTile(index: index, type: TileType.Reps, reps: reps),
              ],
            ),
          ),
    );
  }
}

// ignore: constant_identifier_names
enum TileType { Weight, Reps }

class WeightsRepsTile extends StatelessWidget {
  final int index;
  final TileType type;

  const WeightsRepsTile({
    super.key,
    required this.index,
    required this.type,
    this.reps = 10,
  });
  final int reps;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(type.name, style: FontsManager.lexendMedium(size: 20)),
      subtitle: Text(
        'Set ${index + 1}',
        style: FontsManager.lexendMedium(
          color: ColorsManager.textGrey,
          size: 16,
        ),
      ),
      trailing: SizedBox(
        width: 30,
        height: 40,
        child: TextField(
          style: FontsManager.lexendRegular(size: 14),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintStyle: FontsManager.lexendRegular(size: 14),
            filled: false,
            hintText: type == TileType.Weight ? '0' : '$reps',
            border: UnderlineInputBorder(),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            if (value != '') {
              var nVal = int.parse(value);
              type == TileType.Weight
                  ? context.read<WorkoutSessionCubit>().updateWeight(
                    index,
                    nVal,
                  )
                  : context.read<WorkoutSessionCubit>().updateReps(index, nVal);
            }
          },
        ),
      ),
    );
  }
}

class TimerCircularProgress extends StatefulWidget {
  const TimerCircularProgress({super.key});

  @override
  State<TimerCircularProgress> createState() => _TimerCircularProgressState();
}

class _TimerCircularProgressState extends State<TimerCircularProgress> {
  Stopwatch stopWatch = Stopwatch();
  Timer? till;
  String time = '00:00';
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(seconds: 1),
      (timer) => setState(() {
        time = MM_SS(stopWatch.elapsed);
      }),
    );
    till = Timer(Duration(minutes: 1), () {
      context.read<WorkoutSessionCubit>().nextWorkout();
    });
    stopWatch.start();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: ScreenSizeHelper.width_P(context, 0.6),
                width: ScreenSizeHelper.width_P(context, 0.6),
                child: CircularProgressIndicator(
                  backgroundColor: ColorsManager.grey,
                  color: ColorsManager.green,
                  strokeWidth: 18,
                  value: stopWatch.elapsed.inSeconds.remainder(60) / 60,
                ),
              ),
              Text(time, style: FontsManager.lexendBold(size: 22)),
            ],
          ),
          SizedBox(height: 30),
          Buttons.CostumeButton(
            onPressed: () {
              till!.cancel();
              context.read<WorkoutSessionCubit>().nextWorkout();
            },
            child: Text('Next Exercise'),
            backgroundColor: ColorsManager.grey,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
