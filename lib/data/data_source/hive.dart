import 'package:fit_track/core/data_sources_consts.dart';
import 'package:hive_flutter/adapters.dart';

class NextDayDataSource {
  NextDayDataSource._priv();
  static NextDayDataSource instance = NextDayDataSource._priv();
  final _box = Hive.box(BoxesNames.nextDay);

  Future<int?> getPlanNextDayId(int planId) async => await _box.get(planId);

  Future<void> setPlanNextDayId(int planId, int dayId) async =>
      await _box.put(planId, dayId);
}
