import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/colors_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/domain/entities/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(AssetsManager.dumbbell, scale: 0.7),
          ),
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exercise.name, style: FontsManager.lexendMedium(size: 22)),
            SizedBox(
              width: ScreenSizeHelper.width_P(context, 0.65),
              child: Text(
                exercise.instructions ?? 'No description',
                style: FontsManager.lexendMedium(
                  color: ColorsManager.textGrey,
                  size: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
