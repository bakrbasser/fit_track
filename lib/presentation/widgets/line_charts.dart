import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/chart_helper.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/presentation/cubits/charts/charts_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressChart extends StatefulWidget {
  const ProgressChart({
    super.key,
    required this.titleData,
    required this.dateFetcher,
  });
  final FlTitlesData titleData;
  final Function dateFetcher;
  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  @override
  void initState() {
    super.initState();
    widget.dateFetcher();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSizeHelper.width_P(context, 0.9),
      height: ScreenSizeHelper.height_P(context, 0.3),
      child: BlocBuilder<ChartsCubit, ChartsState>(
        builder: (context, state) {
          if (state is ChartReady) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.title, style: FontsManager.lexendMedium(size: 18)),
                Text(state.subTitle, style: FontsManager.lexendBold(size: 30)),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [_lineBarDataBuilder(state.data)],
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: widget.titleData,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ChartLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

LineChartBarData _lineBarDataBuilder(List<double> data) {
  return LineChartBarData(
    isCurved: true,
    barWidth: 4,
    color: ColorsManager.lightGrey,
    aboveBarData: BarAreaData(color: Colors.transparent),
    belowBarData: BarAreaData(
      show: true,
      gradient: LinearGradient(
        colors: [
          ColorsManager.grey,
          const Color.fromARGB(255, 32, 44, 36),
          Colors.transparent,
        ],

        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    spots: List.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), data[index]),
    ),
  );
}

class WeeklyProgressChart extends StatelessWidget {
  const WeeklyProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgressChart(
      titleData: _weeklyProgressTitlesData(),
      dateFetcher: context.read<ChartsCubit>().weeklyProgress,
    );
  }
}

class ExerciseVolumeChart extends StatelessWidget {
  const ExerciseVolumeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgressChart(
      titleData: _exerciseVolumeTitlesData(),
      dateFetcher: context.read<ChartsCubit>().exerciseVolumeChart,
    );
  }
}

class ExerciseMaxWeightChart extends StatelessWidget {
  const ExerciseMaxWeightChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgressChart(
      titleData: _exerciseVolumeTitlesData(),
      dateFetcher: context.read<ChartsCubit>().exerciseMaxWeightChart,
    );
  }
}

FlTitlesData _weeklyProgressTitlesData() {
  return FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        reservedSize: 40,
        showTitles: true,
        getTitlesWidget: ChartHelper.getWeekDayNameWidgetValue,
        interval: 1,
      ),
    ),
    leftTitles: AxisTitles(),
    rightTitles: AxisTitles(),
    topTitles: AxisTitles(),
  );
}

FlTitlesData _exerciseVolumeTitlesData() {
  return FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        reservedSize: 40,
        showTitles: true,
        getTitlesWidget: ChartHelper.getExerciseVolumeWidgetValue,
        interval: 5,
      ),
    ),
    leftTitles: AxisTitles(),
    rightTitles: AxisTitles(),
    topTitles: AxisTitles(),
  );
}
