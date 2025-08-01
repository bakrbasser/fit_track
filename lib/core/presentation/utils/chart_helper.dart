import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ChartHelper {
  static Widget getWeekDayNameWidgetValue(double value, TitleMeta meta) {
    final day = DateTime.now().subtract(Duration(days: (7 - value).toInt()));
    String date = DateFormat('EEE').format(day);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        date,
        style: FontsManager.lexendMedium(color: ColorsManager.lightGrey),
      ),
    );
  }

  static Widget getExerciseVolumeWidgetValue(double value, TitleMeta meta) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        (value + 1).toString(),
        style: FontsManager.lexendMedium(color: ColorsManager.lightGrey),
      ),
    );
  }
}
