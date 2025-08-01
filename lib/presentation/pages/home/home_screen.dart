import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/domain/entities/training_plan.dart';
import 'package:fit_track/presentation/cubits/charts/charts_cubit.dart';
import 'package:fit_track/presentation/cubits/pages_navigator/pages_navigator_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/list/plans_list_cubit.dart';
import 'package:fit_track/presentation/cubits/plans/today_workout/today_workout_cubit.dart';
import 'package:fit_track/presentation/routes/routes_manager.dart';
import 'package:fit_track/presentation/widgets/general.dart';
import 'package:fit_track/presentation/widgets/line_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FitTrack'), actions: [Settings()]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActivePlanAndWorkout(),
              SizedBox(height: 10),
              Text('Weekly Progress', style: FontsManager.lexendBold(size: 25)),
              SizedBox(height: 10),

              BlocProvider(
                create: (context) => ChartsCubit(),
                child: WeeklyProgressChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivePlanAndWorkout extends StatefulWidget {
  const ActivePlanAndWorkout({super.key});

  @override
  State<ActivePlanAndWorkout> createState() => _ActivePlanAndWorkoutState();
}

class _ActivePlanAndWorkoutState extends State<ActivePlanAndWorkout> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PlansListCubit, PlansListState>(
      listener: (context, state) {
        setState(() {});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Plan', style: FontsManager.lexendBold(size: 25)),
          SizedBox(height: 15),
          SizedBox(
            height: ScreenSizeHelper.height_P(context, 0.17),
            child: ActivePlan(),
          ),
          SizedBox(height: 30),
          Text('Next Workout', style: FontsManager.lexendBold(size: 25)),
          SizedBox(height: 15),
          SizedBox(
            height: ScreenSizeHelper.height_P(context, 0.17),
            child: BlocProvider(
              create: (context) => TodayWorkoutCubit(),
              child: ActiveTraining(),
            ),
          ),
        ],
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.settings));
  }
}

class ActivePlan extends StatefulWidget {
  const ActivePlan({super.key});
  @override
  State<ActivePlan> createState() => _ActivePlanState();
}

class _ActivePlanState extends State<ActivePlan> {
  TrainingPlan? activePlan;

  @override
  void initState() {
    super.initState();
  }

  String name() {
    if (activePlan == null) {
      return 'No active plan';
    }
    return activePlan!.name;
  }

  String description() {
    if (activePlan == null) {
      return 'Please view plans to activate a plan';
    }
    return activePlan!.description ?? 'No description';
  }

  @override
  Widget build(BuildContext context) {
    activePlan = context.read<PlansListCubit>().activePlan;
    return Row(
      children: [
        SizedBox(
          width: ScreenSizeHelper.width_P(context, 0.55),
          child: SizedBox(
            width: ScreenSizeHelper.width_P(context, 0.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name(), style: FontsManager.lexendBold(size: 26)),
                SizedBox(height: 5),
                Text(
                  description(),
                  maxLines: 3,
                  style: FontsManager.lexendRegular(
                    size: 18,
                    color: ColorsManager.textGrey,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.darkGreen,
                  ),
                  onPressed: () {
                    context.read<PagesNavigatorCubit>().navigate(2);
                  },

                  child: Text(
                    'View Plans',
                    style: FontsManager.lexendMedium(
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (activePlan != null) Expanded(child: PlanImage()),
      ],
    );
  }
}

class ActiveTraining extends StatefulWidget {
  const ActiveTraining({super.key});

  @override
  State<ActiveTraining> createState() => _ActiveTrainingState();
}

class _ActiveTrainingState extends State<ActiveTraining> {
  @override
  Widget build(BuildContext context) {
    context.read<TodayWorkoutCubit>().fetchTodayWorkout();
    return BlocBuilder<TodayWorkoutCubit, TodayWorkoutState>(
      builder: (context, state) {
        if (state is FetchedTodayWorkout) {
          return Row(
            children: [
              SizedBox(
                width: ScreenSizeHelper.width_P(context, 0.55),
                child: SizedBox(
                  width: ScreenSizeHelper.width_P(context, 0.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.trainingDay.name,
                        style: FontsManager.lexendBold(size: 26),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${state.trainingsCount * 5} min . ${state.trainingsCount} exercises',
                        maxLines: 3,
                        style: FontsManager.lexendBold(
                          size: 15,
                          color: ColorsManager.textGrey,
                        ),
                      ),
                      SizedBox(height: 30),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.darkGreen,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            Routes.workoutSession,
                            arguments: state.trainingDay,
                          );
                          context
                              .read<TodayWorkoutCubit>()
                              .setPlanNextWorkout();
                        },

                        child: Text(
                          'Start Workout',
                          style: FontsManager.lexendMedium(
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: PlanImage()),
            ],
          );
        } else {
          return Text(
            'There is no active plan please view plans and select one to see next workout',
            maxLines: 3,
            style: FontsManager.lexendRegular(
              size: 18,
              color: ColorsManager.textGrey,
            ),
          );
        }
      },
    );
  }
}
