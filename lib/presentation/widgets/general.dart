import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/presentation/cubits/days/list/days_list_cubit.dart';
import 'package:fit_track/presentation/pages/days/days_screen.dart';
import 'package:fit_track/presentation/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoElements extends StatelessWidget {
  const NoElements({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.5),
      child: Text(
        message,
        style: FontsManager.lexendMedium(size: 22),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TrainingDayBottomBar extends StatefulWidget {
  const TrainingDayBottomBar({super.key});

  @override
  State<TrainingDayBottomBar> createState() => _TrainingDayBottomBarState();
}

class _TrainingDayBottomBarState extends State<TrainingDayBottomBar> {
  @override
  void initState() {
    super.initState();
    context.read<DaysListCubit>().loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSizeHelper.height_P(context, 0.7),
      decoration: BoxDecoration(
        color: ColorsManager.black,
        border: Border(top: BorderSide(color: Colors.white)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: TrainingDaysList(mode: TrainingDayCardMode.select),
    );
  }
}
